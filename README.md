# Data analytics with AsterixDB
A demonstration of data analytics using AsterixDB

## Environmental set up
* This tutorial assumes that you have a Linux, MacOS or Windows machine.
* Download AsterixDB 0.9.4.1 from https://asterixdb.apache.org/ . 
Save the downloaded file at your home directory (/home/user_name, in my case: /home/tvu032).
Unzip the downloaded file.
* Move to the unzipped directory: 
```console
foo@bar: cd /home/tvu032/asterix-server-0.9.4.1-binary-assembly
```
* Start an instance of AsterixDB in local mode:

```console
foo@bar: opt/local/bin/start-sample-cluster.sh
```

* Verify that AsterixDB is running by going to this address on your browser:
http://localhost:19001/ 

You should be able to see a GUI application in which you can execute your SQL++ queries.

## Analyse Chicago Crimes dataset 
* In this demo, we use Chicago Crimes dataset, which you can download from [UCR STAR](https://star.cs.ucr.edu/?Chicago%20Crimes#center=39.373,-89.606&zoom=7).
Please choose the full download.
* For your convenience, we downloaded a subset of the dataset and put it at ./data directory.

### Create data scheme
* Back to the AsterixDB GUI at http://localhost:19001/ , execute the following SQL++ query to create the dataverse of Chicago Crimes dataset.
```sql
DROP DATAVERSE chicago_crimes IF EXISTS;
CREATE DATAVERSE chicago_crimes;
```

* Create a data type called ChicagoCrimeType:
```sql
USE chicago_crimes;

CREATE TYPE ChicagoCrimeType as closed {
    latitude: double?,
    longitude: double?,
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
```

### Load dataset
* Create a dataset of ChicagoCrimeType, choose id as primary key:
```sql
USE chicago_crimes;

CREATE DATASET ChicagoCrimes (ChicagoCrimeType) PRIMARY KEY id;
```

* Load the data from CSV file into the dataset we just created:
```sql
USE chicago_crimes;

LOAD DATASET ChicagoCrimes USING localfs (("path"="127.0.0.1:///home/tvu032/Documents/source_code/asterixdb_demo/crime.csv"), ("format"="delimited-text"), ("delimiter"="\t"), ("header"="true"));
```

## Data analytics using SQL++
