@Grab('com.spotify:dns:3.1.1')
import com.spotify.dns.DnsSrvResolver;
import com.spotify.dns.DnsSrvResolvers;
import com.spotify.dns.LookupResult;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletResponse

@RestController
@ConfigurationProperties
class Scanner {
  String greeting
  String dnsBase
  DnsSrvResolver resolver = DnsSrvResolvers.newBuilder()
  	       		              .dnsLookupTimeoutMillis(1000)
                            .build()

  @RequestMapping("/")
  String home() {
    return "$greeting!"
  }

  @RequestMapping(value = "/{service}", produces = "text/plain; charset=utf-8")
  String lookup(@PathVariable String service) {
    String address = service + "." + dnsBase
    String result = "Looking up $address:\n"
    for (rec in resolver.resolve(address)) {
      result += "$rec\n"
    }
    return result
  }
}
