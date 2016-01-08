# modules/dart/manifests/mdct_ngic_dev.pp
#
# Synopsis:
#       NGIC Materials Database (testing and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct_ngic_dev inherits dart::abstract::ngic_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

    class { '::network':
        service => 'legacy',
    }
    
    iptables::tcp_port {
        'http_external': port => '80';
    }

    class { 'apache':
        network_connect => true,
    }

    apache::site_config {
        '99-proxy-ajp':
            content   => "
<IfModule proxy_ajp_module>
    <IfModule headers_module>
        RequestHeader unset Expect early
    </IfModule>
    <LocationMatch ^/>
        ProxyPassMatch ajp://127.0.0.1:8009 timeout=3600 retry=5
        <IfModule deflate_module>
            AddOutputFilterByType DEFLATE text/javascript text/css text/html text/xml text/json application/xml application/json application/x-yaml
        </IfModule>
    </LocationMatch>
</IfModule>
";
    }

    network::interface { 'eth0':
            template   => 'static',
            ip_address => '10.201.64.9',
            netmask    => '255.255.252.0',
            gateway    => '10.201.67.254',
            stp        => 'no',
    }

}
