@Grab('com.spotify:dns:3.1.1')
import com.spotify.dns.DnsException;
import com.spotify.dns.DnsSrvResolver;
import com.spotify.dns.DnsSrvResolvers;
import com.spotify.dns.LookupResult;
import com.spotify.dns.statistics.DnsReporter;
import com.spotify.dns.statistics.DnsTimingContext;

println "hello world"
DnsSrvResolver resolver = DnsSrvResolvers.newBuilder()
	       		  .dnsLookupTimeoutMillis(1000).build()
for (arg in args) {
	def results = resolver.resolve(arg)
	for (result in results) {
		println result
	}
}
