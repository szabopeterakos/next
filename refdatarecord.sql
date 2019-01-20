[EEAEPP-21231][ref-data-web-service] Implement backend for imsi/msisdn lookup

./docker_environment.py --start -l 
\\\vagy//// 
./docker_environment.py --start -d

docker ps
./docker_environment.py -d --reload


demo dev
addat be
docker exec -it eea-gp bash
psql -d network -U eearefuser -p 5555
SET search_path = cea;
select * from crm_customer_device_info // cea. (search path)

https://localhost/api/referencedata/swagger.html

jboss-hc-1
hc-123

select imsi, imei, tac, customer_full_name,customer_type,maxrate_dl,maxrate_ul,contract_expiration_date from cea.crm_customer_device_info inner join cea.msisdn_imsi_map on cea.crm_customer_device_info.imi =  msisdn_imsi_map.imsi;


select imsi,imei,tac,customer_full_name,customer_type,maxrate_dl,maxrate_ul,contract_expiration_date 
from crm_customer_device_info limit 10;


select imsi,msisdn from msisdn_imsi_map limit 10;

valid test data:
msisdn = 122212240872248  - > de : 401903311469477
msisdn = 122212345671100  - > de : 472910270997104
ims = 12343353946583 -> decript : 12343342036302

insert into msisdn_imsi_map (imsi,msisdn) values (122212240872248,122212240872248);
insert into msisdn_imsi_map (imsi,msisdn) values (122212348271277,122212240872248);
insert into msisdn_imsi_map (imsi,msisdn) values (201301020869894,122212240872248);

select imsi from msisdn_imsi_map where msisdn = 122212240872248;

select msisdn_imsi_map.imsi,imei,tac,customer_full_name,crm_customer_device_info.customer_type,maxrate_dl,maxrate_ul,contract_expiration_date 
from crm_customer_device_info 
inner join msisdn_imsi_map on crm_customer_device_info.imsi = (select imsi from msisdn_imsi_map where msisdn = 122212240872248 order by imsi desc limit 1);

select * from information_schema.tables;

select imsi,customer_full_name,customer_type,email_id,plan_type from crm_customer_device_info where imsi = 12343353946583;

select imsi,customer_full_name,customer_type,email_id,plan_type,last_mod from cea.crm_customer_device_info where last_mod is not null;

select * from cea.crm_customer_device_info where 
last_mod is not null
last_mod is not null
last_mod is not null
;

CRM

{
     "key": [
       {
         "name": "imsi",
         "value": 12343342036302,
         "dataType": "INT64"
       }
     ],
     "requestedDimensionNames": [
       "imsi", "customer_full_name", "customer_type", "email_id", "last_mod", "plan_type", "plan_description"
     ]
}


    public RequestParam getCrmRequestParamByImsi(String imsi) {
        RequestParam param = new RequestParam();

        RequestParamField msisdnKey = new RequestParamField();
        msisdnKey.setName("imsi");
        msisdnKey.setValue(imsi);
        msisdnKey.setDataType(DataType.INT64);
        param.setKey(new ArrayList<>(Arrays.asList(msisdnKey)));

        ArrayList<String> dimensions = new ArrayList<String>(Arrays.asList(
                "imsi",
                "customer_full_name",
                "email_id",
                "plan_type",
                "customer_type"
                ));
        param.setRequestedDimensionNames(dimensions);

        return param;
    }

TAC code (first eight digits of device IMEI, or first six digits for 13-byte IMEIs)

device info by IMSI:
select model from cea.tac where imeitac = {IMSI};

ref data one record:

{
  "key": [
    {
      "name": "msisdn",
      "value": 122212240872248,
      "dataType": "INT16"
    }
  ]
}

ref data records:

{
  "keys": [
    [
      {
        "name": "msisdn",
        "value": 401903311469477,
        "values": [
          
        ],
        "dataType": "INT8"
      }
    ]
  ]
}

ref data records: [response] 

[
  {
    "fields": [
      {
        "name": "imsi",
        "value": 3333333333
      }
    ]
  },
  {
    "fields": [
      {
        "name": "imsi",
        "value": 122212735578514
      }
    ]
  },
  {
    "fields": [
      {
        "name": "imsi",
        "value": 201301401501640
      }
    ]
  },
  {
    "fields": [
      {
        "name": "imsi",
        "value": 122212735578511
      }
    ]
  }
]


ger records:

{
  "keys": [
    [
      {
        "name": "msisdn",
        "value": 401903311469477,
        "values": [
        ],
        "dataType": "INT8"
      }
    ],[
      {
        "name": "msisdn",
        "value": 472910270997104,
        "values": [
        ],
        "dataType": "INT8"
      }
    ]
  ]
}