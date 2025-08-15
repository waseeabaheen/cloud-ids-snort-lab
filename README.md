# Cloud Intrusion Detection Lab – OpenStack + Snort IDS

Hands-on lab showcasing cloud attack simulation and detection with **OpenStack**, **Snort**, and **hping3**. 
You deploy two VMs (Attacker + Sensor), launch network attacks, and detect them with Snort rules. 
Perfect as a portfolio project or teaching aid.

## What you’ll do
- Provision **two OpenStack instances** on a private network (Ubuntu recommended).
- Install & configure **Snort** on the Sensor VM.
- Simulate ICMP flood and TCP SYN scan using **hping3** from the Attacker VM.
- Capture **Snort alerts** and generate a short analysis report.
