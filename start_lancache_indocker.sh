echo "Starting containers"
echo "Starting DNS"
docker run --restart unless-stopped --name lancache-dns --detach -p 53:53/udp -e USE_GENERIC_CACHE=true -e LANCACHE_IP=$HOST_IP lancachenet/lancache-dns:latest
echo "Starting Lancache"
docker run --restart unless-stopped --name lancache --detach -v /vault/storage/lancache:/data/cache -v /vault/storage/lancache/logs:/data/logs -p 80:80 lancachenet/monolithic:latest 
echo "Starting Proxy"
docker run --restart unless-stopped --name sniproxy --detach -p 443:443 lancachenet/sniproxy:latest
echo Please configure your router/dhcp server to serve dns as $HOST_IP
