/* in schema addbase:

ways_osbg
ways_osgb_vertices_pgr      the pgRouting network


pcds_ops_a

    for each postcode, all bus departures it can catch - time of departure, stop, and the tracking id ingr1_sig_id


egrx_a

    the egress (exit) points for every tracked bus journey (ingr1_sig_id)
    where and when journey started, bus route

    whether a transfer was involved - if so when and where

    point of departure
        egr_arr, egr_stop, acc_time
        time of arrival, stop, bus  route, total journey time to this point


od_abconn_stop_400_nwd

    network proximity of commercial sites and bus stops

    from_id = bus stop id (field "stop_id")
    to_id   = new_ab_commerical id code (field "id")
    nwd = walk distance


So, can use JOINs to string these together...

For example, all commerical sites reachabe from postcode SA1 1AA where bus arrives between 8am and 9am...

*/

SELECT distinct to_id

from	addbase.pcd_ops_a   				as po
join	addbase.egrx_a   					as ex
	on po.ingr1_sig_id = ex.ingr1_sig_id
join 	addbase.od_abcomm_stop_400_nwd 		as ab
	on ex.egr_stop = ab.from_id

where
	po.postcode='SA1 1AA'
and
	egr_arr between '08:00:00' and '09:00:00'
