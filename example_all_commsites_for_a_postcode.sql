/* in schema addbase:

ways_osbg
ways_osgb_vertices_pgr      are the pgRouting network files


pcds_ops_a

    for each postcode, tell us about all bus departures that people here
    can catch from stops that fall within 400m walking distance
    - includes the time of bus departure, the bus stop id, and most importantly, the tracking code: id ingr1_sig_id


egrx_a

    this table tells us which bus stops passengers might get off at after catching the
    bus identified by the ingr1_sig_id. in other words, all egress (exit) points for every tracked bus journey (ingr1_sig_id)
    - includes where and when the journey started, and initial bus route
    - then details of any transfers involved - if so, when and where
	- then the bus stop of departure
        egr_arr: time bus arrived here, egr_stop: the bus stop id, acc_time: how long since journey began



od_abconn_stop_400_nwd

    maps the network proximity of commercial sites to bus stops
    so, for a given bus stop, which commercial sites can be reached by a 400m max walk

    from_id = this is a bus stop id (field "stop_id")
    to_id   = this is a "new_ab_commerical" point's id code (field "id")
    nwd = the network walk distance between


So, putting this togeether, we can now use JOINs to string these tables together...

For example, to identify all commerical sites that are reachabe from postcode SA1 1AA
and where the bus arrives at the exit stop between 8am and 9am in the morning...

...this gives us a list of id values which reference the set of points held in the "new_ab_commercial" table

*/


SELECT distinct to_id        --use distinct to avoid counting the comemrcial site more than once
	
--start with the list of bus departures by postcode table
from	addbase.pcd_ops_a   				as po

--join to the egress points tracking table: for each ingr1_sig_id code (i.e. a specific bus departure from a specific stop at a specific time)
--this table lists details all of the donwstream stops that could then be reached in a 30 minute travel time
join	addbase.egrx_a   					as ex
	on po.ingr1_sig_id = ex.ingr1_sig_id

--join to the od matrix that then tells us
join 	addbase.od_abcomm_stop_400_nwd 		as ab
	on ex.egr_stop = ab.from_id

where
	po.postcode='SA1 1AA'
and
	egr_arr between '08:00:00' and '09:00:00'


/*

We just need to add another join to add the ab_commercial job counts, then add the values up,
to yield an estimate of access to employment from this postocde.

/*
