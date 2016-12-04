
# README

Get Maven: http://maven.apache.org/download.cgi
Then go through these instructions: http://beam.incubator.apache.org/get-started/quickstart/
WordCount example downloads in around 2 mins
NB: NOT IN THE OFFICIAL DOCUMENTATION - THESE LINES MUST BE ADDED to the generated pom.xml:


    <activation>
        <activeByDefault>true</activeByDefault>
    </activation>


Download <https://raw.githubusercontent.com/cs109/2015/master/Lectures/Lecture15b/sparklect/shakes/kinglear.txt>


Then run:


    mvn compile exec:java -Dexec.mainClass=org.apache.beam.examples.WordCount      -Dexec.args="--inputFile=kinglear.txt --output=counts"

Or:

    mvn compile exec:java -Dexec.mainClass=org.apache.beam.examples.WordCount      -Dexec.args="--inputFile=Capital-Volume-I.txt --output=counts-marx"


Then do:

    more counts*


Command to run the WordCount example on Google Cloud DataFlow (ie. to test the operations of parallel processing with Apache Beam on Google’s infrastructure):


First setup an account, project and file bucket on Google Cloud: http://beam.incubator.apache.org/documentation/runners/dataflow/ and https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven


 - Make sure the Google DataFlow API is enabled
 - Install the Google Cloud SDK: https://cloud.google.com/sdk/
 - Authenticate:

    gcloud auth application-default login

 - Make the backup writable:

    gsutil acl set public-read-write gs://composed-setup-147223.appspot.com

 - If necessary, upload files to the Google Cloud bucket:

    gsutil cp kinglear.txt gs://composed-setup-147223.appspot.com/
    gsutil cp Capital-Volume-I.txt gs://composed-setup-147223.appspot.com/

Run with the Dataflow Runner:


    mvn compile exec:java -Dexec.mainClass=org.apache.beam.examples.WordCount \
     -Dexec.args="--inputFile=gs://composed-setup-147223.appspot.com/kinglear.txt --output=gs://composed-setup-147223.appspot.com/counts/ --runner=DataflowRunner --project=composed-setup-147223 --gcpTempLocation=gs://composed-setup-147223.appspot.com"


    mvn compile exec:java -Dexec.mainClass=org.apache.beam.examples.WordCount \
     -Dexec.args="--inputFile=gs://composed-setup-147223.appspot.com/Capital-Volume-I.txt --output=gs://composed-setup-147223.appspot.com/counts-marx --runner=DataflowRunner --project=composed-setup-147223 --gcpTempLocation=gs://composed-setup-147223.appspot.com"

Download files from Google Cloud:

    ~/Downloads/google-cloud-sdk/bin/gsutil cp "gs://composed-setup-147223.appspot.com/counts-marx*" .


Join the outputs:

    cat counts-marx-00000-of-00003 counts-marx-00001-of-00003 counts-marx-00002-of-00003 > counts-marx-00003



## Trace and graph the network traffic

While running, get the processing ID:

    ps aux | grep java

Then 

    nettop -p [THE RETURNED PROCESS ID]

To generate a KML of the network route between source and destination IP addresses:

    sudo nmap --traceroute --script traceroute-geolocation --script-args 'traceroute-geolocation.kmlfile=test.kml' [RETURNED IP ADDRESS]

This can be uploaded to [Google My Maps](www.google.com/mymaps) to visualise.

[Note: consider OSM alternative - conversion to GPX, JOSM]

Shortcut for Mac partial screenshot

    Command + Control + Shift + 4

## Graph output

Open the *word-count-beam.Rproj* file in *RStudio* and execute the *analyis.R* script.

It should generate something like the following:

![Top 50 words in Capital](counts-marx-plotted.png)

