# Tredius projects

## Big Data, Big Analytics

Hadoop, the clear king of big-data analytics, is focused on batch processing.
This model is sufficient for many cases (such as indexing the web), but other
use models exist in which real-time information from highly dynamic sources is
required. Solving this problem resulted in the introduction of Storm from
Nathan Marz (now with Twitter by way of BackType). Storm operates not on static
data but on streaming data that is expected to be continuous. With Twitter
users generating 140 million tweets per day, it's easy to see how this
technology is useful.

But Storm is more than a traditional big-data analytics system: It's an example
of a **complex event-processing (CEP) system**. CEP systems are typically
categorized as *computation and detection oriented*, each of which can be
implemented in Storm through user-defined algorithms. CEPs can, for example, be
used to *identify meaningful events from a flood of events*, and then take
actions on those events in real time.

Nathan Marz provides a number of examples in which Storm is used within
Twitter. One of the most interesting is the generation of **trend information**.
Twitter extracts emerging trends from the fire hose of tweets and maintains
them at the local and national level. What this means is that as a story begins
to emerge, Twitter's trending topics algorithm identifies the topic in real
time. This real-time algorithm is implemented within Storm as a continuous
analysis of Twitter data.
<http://www.ibm.com/developerworks/library/os-twitterstorm/>


