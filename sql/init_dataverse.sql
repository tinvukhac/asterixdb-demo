DROP DATAVERSE chicago_crimes IF EXISTS;
CREATE DATAVERSE chicago_crimes;

USE chicago_crimes;

-- Make Chicago crime data type

CREATE TYPE ChicagoCrimeType as closed {
    longitude: double?,
    latitude: double?,
    id: int32,
    case_number: string?,
    date_value: string?,
    block: string?,
    iucr: string?,
    primary_type: string?,
    description: string?,
    location_description: string?,
    arrest: string?,
    domestic: string?,
    beat: double?,
    district: double?,
    ward: double?,
    community_area: double?,
    fbi_code: string?,
    x_coordinate: double?,
    y_coordinate: double?,
    year: int32?,
    updated_on: string?,
    location: string?
};

-- Make Chicago crime dataset
CREATE DATASET ChicagoCrimes (ChicagoCrimeType) PRIMARY KEY id;

-- Load csv data into dataset
LOAD DATASET ChicagoCrimes USING localfs (("path"="127.0.0.1:///Users/tinvu/OneDrive/Desktop/asterix-server-0.9.4.1-binary-assembly/datasets/chicago_crimes_sample.csv"), ("format"="delimited-text"), ("delimiter"="\t"), ("header"="true"));
