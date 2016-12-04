
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


Then do 

    more counts*


Command to run the WordCount example on Google Cloud DataFlow (ie. to test the operations of parallel processing with Apache Beam on Google’s infrastructure):


First setup an account, project and file bucket on Google Cloud: http://beam.incubator.apache.org/documentation/runners/dataflow/

 - Make sure the Google DataFlow API is enabled
 - Install the Google Cloud SDK: https://cloud.google.com/sdk/
 - If necessary, upload files to the Google Cloud bucket:

    gsutil cp kinglear.txt gs://composed-setup-147223.appspot.com/
    gsutil cp Capital-Volume-I.txt gs://composed-setup-147223.appspot.com/

Run with the Dataflow Runner:


    mvn compile exec:java -Dexec.mainClass=org.apache.beam.examples.WordCount \
     -Dexec.args="--inputFile=gs://composed-setup-147223.appspot.com/kinglear.txt --output=gs://composed-setup-147223.appspot.com/counts/ --runner=DataflowRunner --project=composed-setup-147223 --gcpTempLocation=gs://composed-setup-147223.appspot.com"



