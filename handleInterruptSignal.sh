function handle_interrupt_signal() {
  echo "Handling interrupt signal"
  exit 0
}

trap handle_interrupt_signal 2

read -p "Enter something"
while [ 1 ]; do
  echo "about to sleep"
  sleep 1
done
