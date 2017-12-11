#cloud-config

coreos:
  update:
    reboot-strategy: "off"
  units:
    - name: update-engine.service
      command: stop
      mask: true

    - name: locksmithd.service
      command: stop
      mask: true
