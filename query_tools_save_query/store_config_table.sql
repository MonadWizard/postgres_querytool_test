-- store_config_table.sql

-- CREATE SHOPE CONFIGURATION Table

-- CREATE TABLE "ShopConfigurationTable" (
-- 	"storeid" VARCHAR PRIMARY KEY,
-- 	"storeDetails" JSON,
-- 	"storeNavBar" JSON,
-- 	"storeHomeLandingView" JSON,
-- 	"storeHomeScrollPage" JSON,
-- 	"storeFooter" JSON,
-- 	"storeReservationTypes" JSON,
-- 	"storereservationReqirenments" JSON,
-- 	"storeContactUsShopInfo" JSON,
-- 	"storecustomerSignUpAllowedField" JSON,
-- 	"storeCustomersignUpableSocialAuthData" JSON,
-- 	"storeCustomerCartEnableField" JSON
-- );



-- INSERT DATA TO ShopeConfiguration TABLE

INSERT INTO public."ShopConfigurationTable"(
	storeid, "storeDetails", "storeNavBar", "storeHomeLandingView", "storeHomeScrollPage", "storeFooter", "storeReservationTypes", "storereservationReqirenments", "storeContactUsShopInfo", "storecustomerSignUpAllowedField", "storeCustomersignUpableSocialAuthData", "storeCustomerCartEnableField")
	VALUES (current_timestamp, 
-- 	storeDetails		
'{
	"licence information" : "licence",
	"store name" : "storeName",
	"store opening date" : "22-12-1999", 
	"trade licence no" : "23456789876543",
	"trade licence picture" : "http://gfghjk.ghj.jhk", 
	"store owner name" : "demo Name", 
	"store owner cell phone" : "234567890654",
	"store owner email" : "email@email.com", 
	"store owner state registered ID / National ID / Passport" : "erftyghjlkjhgftyuijlhkjhgtjyg",
	"store cell no" : "34657890",
	"store email" : "email@emai.com",
	"store address" : ["can", "be", "multi location"],
	"store google map link": "http://fghjkl.ds.sdf",
	"store opening time": "6am UTC+06",
	"store closing time" : "12am UTC+06",
	"store manager name" : "demo manager", 
	"store manager cell phone" : "234567890",
	"store manager email" : "emaul@email.com", 
	"enable google map drop pin within app / webpage" : "http://dsdfds/sffs/sf",
	"intigrade stores google API" : "wertyuioiyw" 
}',

-- 	storeNavBar
'{
	"store_logo": "image_url",
	"store_logo_thumbnale": "image_thumbnale_url",
	"store_name": "store_name",
	"topnavbar_firstbutton": "HOME",
	"topnav_secondbutton": "MENU",
	"topnav_thirdbutton": "Reservation",
	"topnav_fourthbutton": "Contract",
	"topnav_fifthbutton": "signIn",
	"topnav_sixthbutton": "cartItem"

}', 

-- 	storeHomeLandingView
			
'{
	"typeOfView": "frame Type",
	"landingData":[
		{"landingImage1": "image_url",
		"BoldText1": "Title Data",
		"description": "Discription Data",
		"button1": "url"},
		{"landingImage2": "image_url",
		"BoldText2": "Title Data",
		"short_description": "Short Discription Data",
		"button2": "url"}
	]
}', 

-- 	ShopHomeScrollPage
			
'{
	"typeOfView": "frame Type",

	"firstScrollData":[
	{"Image1": "image_url",
	"BoldText1": "Title Data",
	"description": "Discription Data",
	"button1": "url"}],

	"secondScrollData":[
	{"Image2": "image_url",
	"BoldText2": "Title Data",
	"description": "Discription Data",
	"button2": "url"}],

	"thirdScrollData":[
	{"Image3": "image_url",
	"BoldText3": "Title Data",
	"description": "Discription Data",
	"button3": "url"}]
}',
			
-- 	Footer
			
'{
	"footer_firstbutton": "Gallery",
	"footer_secondbutton": "Testimonials",
	"copy-right": "© All Content Rights Reserved, <shopname/> <licence_purchase_year/>"
}', 
	
-- 	shopReservationTypes
'{
	"privateReservation_title": "Blla",
	"privateReservation_discription": "Blla Blla black ship",
	"privateReservation_RestaurentFecilities": [{"icon/image": "web_url","FecilityName": "discribe your facality"},{"icon/image": "web_url","FecilityName": "discribe your facality"}],
	"privateReservationLocation": ["any","thing","can","be"],
	"privateReservationTimePeriod": ["any","time","value","considering store opening and closing time"],


	"contractWithManagerEmail": ["email@mail.com", "email2@mail.com"],
	"contractWithManagerphone": ["24356789", "4356789"],
	

	"corporateReservation_title":"London",
	"corporateReservation_description": "I have been from London",
	"corporateReservationFecilities": [{"icon/image": "web_url","FecilityName": "discribe your facality"},{"icon/image": "web_url","FecilityName": "discribe your facality"}],
	"corporateReservationLocation": ["any","thing","can","be"],
	"privateReservationTimePeriod": ["any","thing","can","be"],


	"eventReservation_title": "Hampty",
	"eventReservation_discription": "Hampty Dampty sat on a wall",
	"eventReservationFecilities": [{"icon/image": "web_url","FecilityName": "discribe your facality"},{"icon/image": "web_url","FecilityName": "discribe your facality"}],
	"eventReservationLocation": ["any","thing","can","be"],
	"eventReservationTimePeriod": ["any","thing","can","be"]
}', 
--  reservationReqirenmentsForProducts
'{
	"isSpecialReqirenment": true,
	"isDineIn": true,
	"isCurtly": false
}',
 
 
-- 	ContactUsShopInfo	
'{
	"shopGooglemapLocation_long": "354678",
	"shopGooglemapLocation_lat": "56778",
	"LocationLogo": "image_URL",
	"ShopAddress": "ShopDetails->storeAddress",
	"ShopContractNumber": ["from", "shop", "info data"],
	"ShopSocialLinkLOGO1": "image_url",
	"ShopSocialLinkURL1": "socialLink_url",
	"ShopSocialLinkLOGO2": "image_url",
	"ShopSocialLinkURL2": "socialLink_url",
	"ShopSocialLinkLOGO3": "image_url",
	"ShopSocialLinkURL3": "socialLink_url"
}', 

-- 	customerSignUpAllowedField

'{
	"IsUserFullName": "true",
	"IsUserEmail": "false",
	"IsUserPhoneNumber": "false",


	"IsGoogleSocialAuth": 1,
	"IsFacebookSocialAuth": 1,
	"IsLinkedInSocialAuth": 1,
	"IsTwitterSocialAuth": 1,
	"IsAppleSocialAuth": 1,

	"IsCustomerCountryName": 1,
	"IsCustomerCityName": 1,
	"IsCustomerStateName": 1,
	"IsCustomerZipNumber": 1,
	"IscustomerLocalAddress:": 1
}',

-- CustomersignUpableSocialAuthData
'{
	"Google_web_ClientID": "wretyuoipouter",
	"Google_android_ClientID": "wretyuoipouter",
	"Google_ISO_ClientID": "wretyuoipouter",
	"Twitter_API_KEY": "rytuio",
	"Twitter_API_secretKEY": "rfhghytuio"
}', 
-- 	CustomerCartEnableField		
'{
	"visualPurchaseType": 
	[{"purchaseType": "Delivary"},
		{"purchesExtraField": ["Delivery Location", "location name, address format from set sata previously & Address"]},

		{"purchaseType": "Pick At <platform_setting.store_type/>"},
		{"purchesExtraField": "if multi shop then from which store dropdown"},

		{"purchaseType": "Dine In"},
		{"purchesExtraField": ["if multi store then which store picker", "or if single store then single store address and name", "SelectTotalGuest"]}
	],

	"isCurtly": 1
}'
);



SELECT * FROM public."ShopConfigurationTable" ORDER BY storeid LIMIT 1;

select * from public."ShopConfigurationTable" where storeid = '2022-11-13 23:56:52.147015+06';

select "storeDetails" ->> 'licence information' from public."ShopConfigurationTable" where storeid = '2022-11-13 23:56:52.147015+06';



select "storeDetails" ->> 'licence information' , "storeNavBar" ->> 'store_name' , "storeHomeLandingView" ->> 'BoldText1', "storeHomeScrollPage" ->> 'firstScrollData', 
"storeFooter" ->> 'copy-right', "storeReservationTypes" ->> 'privateReservationTypes', "storereservationReqirenments" ->> 'isSpecialRequirenment', "storeContactUsShopInfo" ->> 'LocationLogo',
"storecustomerSignUpAllowedField" ->> 'IsUserFullName', "storeCustomersignUpableSocialAuthData" ->> 'Google_web_ClientID', "storeCustomerCartEnableField" ->> 'visualPurchaseType'
from public."ShopConfigurationTable" where storeid = '2022-11-13 23:56:52.147015+06';





select "storeDetails" ->> 'licence information' from public."ShopConfigurationTable" where storeid = '2';

select * from public."ShopConfigurationTable" where "storeReservationTypes" ->> 'privateReservation_title' = 'Blla1';


select "storeDetails" ->> 'licence information' from public."ShopConfigurationTable" where "storeReservationTypes" ->> 'privateReservation_title' = 'Blla1';

-- select storeDetails ->> 'licence information' as Licence from public."ShopConfigurationTable" where storeReservationTypes -> 'privateReservation_title' = Blla1;





-- Calculate Size

SELECT l.metric, l.nr AS bytes
     , CASE WHEN is_size THEN pg_size_pretty(nr) END AS bytes_pretty
     , CASE WHEN is_size THEN nr / NULLIF(x.ct, 0) END AS bytes_per_row
FROM  (
   SELECT min(tableoid)        AS tbl      -- = 'public.tbl'::regclass::oid
        , count(*)             AS ct
        , sum(length(t::text)) AS txt_len  -- length in characters
   FROM   public."ShopConfigurationTable" t                     -- provide table name *once*
   ) x
CROSS  JOIN LATERAL (
   VALUES
     (true , 'core_relation_size'               , pg_relation_size(tbl))
   , (true , 'visibility_map'                   , pg_relation_size(tbl, 'vm'))
   , (true , 'free_space_map'                   , pg_relation_size(tbl, 'fsm'))
   , (true , 'table_size_incl_toast'            , pg_table_size(tbl))
   , (true , 'indexes_size'                     , pg_indexes_size(tbl))
   , (true , 'total_size_incl_toast_and_indexes', pg_total_relation_size(tbl))
   , (true , 'live_rows_in_text_representation' , txt_len)
   , (false, '------------------------------'   , NULL)
   , (false, 'row_count'                        , ct)
   , (false, 'live_tuples'                      , pg_stat_get_live_tuples(tbl))
   , (false, 'dead_tuples'                      , pg_stat_get_dead_tuples(tbl))
   ) l(is_size, metric, nr);




SELECT pg_size_pretty(pg_total_relation_size('public."ShopConfigurationTable"')); 

SELECT pg_size_pretty(pg_database_size('bbq_db'));

