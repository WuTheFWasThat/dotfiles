watch_traffic () {
  sudo tcpdump -i any -s 0 -n port 53
}
