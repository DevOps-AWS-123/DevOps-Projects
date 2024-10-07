###1. Disk Space & Filesystem Management
df -Thi | grep -vE '^Filesystem | tmpfs' ##Displays disk space usage in human-readable format.
du -sh * | sort -rh | head -n 10 ##Summarizes disk usage of a directory.
lsblk: ##Lists all block devices (disks and partitions).
fdisk -l: ##Shows partition tables and disk details.
mount / umount: ##Mounts/unmounts filesystems.
tune2fs: ##Adjusts filesystem parameters, useful for optimizing performance.

###2. Networking
ip addr: ###Displays IP addresses and network interfaces.
ping <host>: ###Tests network connectivity.
traceroute <host>: ###Traces the route packets take to a network host.
netstat -tulpn: ##Displays active TCP/UDP ports.
ss -tulpn: ###Similar to netstat but faster and more efficient.
iptables: ##Firewall management (older system); UFW and firewalld are more common nowadays.
ufw: ###Simple firewall management for Ubuntu systems.
curl -I <URL>: ##Fetches HTTP headers to troubleshoot web server issues.

##3. System Monitoring & Troubleshooting
top / htop / ps -ef ##Real-time view of processes and resource usage.
vmstat: ###Displays system performance metrics (CPU, memory, etc.).
iostat: ##Monitors CPU, disk I/O performance.
free -m: ##Shows memory usage in MB.
dmesg: ##Displays kernel ring buffer messages (useful for identifying hardware or driver-related issues).
journalctl --output=j ##Views systemd logs.
ps aux --sort=%mem/cpu | sort -rh | head -n 10 ##Lists running processes.
kill / killall: ##Terminates processes by ID or name.
systemctl: ##Controls system services (start, stop, restart services).

###4. File & Directory Management
ls -l: ##Detailed listing of directory contents.
cp -r <source> <destination>: ##Copies directories and files.
mv <source> <destination>: ##Moves/renames files.
rm -rf <directory>: ##Removes directories and contents.
find /path -name <filename>: ##Searches for files by name.
chmod: ##Changes file permissions.
chown: ##Changes file ownership.

####5.Log Management
tail -f /var/log/syslog: ###Monitors a log file in real-time.
less /var/log/<logfile>: ##View log files.
grep 'error' /var/log/<logfile>: ##Searches for specific text in log files.

###File Transfer
scp <file> <user>@<host>:<destination>: ##Securely copies files between servers.
rsync -avz <source> <destination>: ##Syncs files between local/remote systems.


##Package Management
apt-get / yum / dnf: ##Install, update, and remove packages on Debian-based (Ubuntu) or Red Hat-based systems.
dpkg -i <package.deb>: ##Installs .deb packages on Debian-based systems.
rpm -ivh <package.rpm>: ##Installs .rpm packages on Red Hat-based systems.

ps aux:
##This command lists all running processes on the system, showing details like the user, 
##process ID (PID), CPU and memory usage, and the command that started the process. 
##It's commonly used for troubleshooting processes that might be consuming too many 
##resources or causing issues.

df -h
###This command shows the disk space usage of your file systems in a 
###human-readable format (i.e., with sizes like KB, MB, GB). 
###It's great for checking how much free space is available 
###and how much is used on each mounted partition.

du -h
##This command displays the disk usage of files and directories in a human-readable format. 
##It's useful when you need to identify large files or directories consuming disk space.

##Additional Options for Each Command

##ps aux Additional Options:
ps aux | grep <process>: ##To search for a specific process.
ps aux --sort=-%mem | head -n 10 ##Sort processes by memory usage.
ps aux --sort=-%cpu | head -n 10 ##Sort processes by CPU usage.

##df -h Additional Options:
df -i: ##Shows inode usage, useful if you run out of inodes even though there’s free disk space.
df -T: ##Shows the file system type (e.g., ext4, xfs, etc.).

##du -h Additional Options:
du -sh * | sort -rh | head -n 10 ##Summarizes the size of each file and directory in the current folder.
du -sh ##/path/to/folder: Shows the size of a specific folder.
du -ah ##/path: Lists all files and folders recursively with their sizes.


##########################troubelshoouting issues##########################################

System and Process Issues
High CPU Usage by a Process

Symptom: System is slow or unresponsive.
Troubleshooting:
Use top or htop to identify the process.
Use ps aux | grep <PID> for further details.
Investigate the process or restart it using systemctl restart <service>.

Out of Memory (OOM) Issue
Symptom: Processes are killed, system is unresponsive.
Troubleshooting:
Check memory usage: free -m.
Identify memory-hogging processes: top or ps aux --sort=-%mem.
Consider adding swap space or tuning application memory usage.

Service Fails to Start
Symptom: Service does not start or crashes after starting.
Troubleshooting:
Check service status: systemctl status <service>.
Inspect logs: journalctl -xe or /var/log/<service>.log.
Ensure configuration files are valid, then restart the service.

Disk Space Full
Symptom: Unable to write files, system errors.
Troubleshooting:
Check disk usage: df -h.
Identify large files: du -sh * | sort -rh | head.
Delete or archive unused files, or resize partitions.

Zombie Processes
Symptom: High load, but no active processes.
Troubleshooting:
Identify zombies: ps aux | grep 'Z'.
Find and restart the parent process to clean up the zombie.

Network-Related Issues
DNS Resolution Failure
Symptom: Unable to reach websites or services by hostname.
Troubleshooting:
Test DNS: nslookup <hostname> or dig <hostname>.
Check /etc/resolv.conf for valid DNS server entries.
Use alternative DNS like Google DNS (8.8.8.8) for testing.

Service Port Not Open
Symptom: Service is running, but inaccessible.
Troubleshooting:
Check if the service is listening on the port: ss -tuln | grep <port>.
Verify firewall rules (UFW or iptables).
Ensure service configuration allows connections from external networks.
Packet Loss / Network Latency

Symptom: Slow network or intermittent connectivity.
Troubleshooting:
Ping the server: ping <host>.
Trace the route: traceroute <host>.
Check network congestion or faulty hardware.

IP Conflict
Symptom: Two machines with the same IP address.
Troubleshooting:
Use arp -a to view MAC address mappings.
Identify conflicting devices and assign unique IPs.

Unable to Connect to Database
Symptom: Application cannot reach the database.
Troubleshooting:
Check database server status: systemctl status <db-service>.
Verify network access and firewall rules.
Ensure correct credentials and database URL in configuration files.
File System and Storage Issues
File Corruption

Symptom: Files cannot be read or are corrupted.
Troubleshooting:
Use fsck to check the filesystem integrity.
Restore corrupted files from a backup if available.
NFS Share Unmounted

Symptom: NFS share is not accessible.
Troubleshooting:
Check the mount status: mount | grep nfs.
Remount using: mount -a.
Ensure the NFS server is running and accessible.
Slow Disk I/O

Symptom: Slow read/write performance.
Troubleshooting:
Monitor I/O performance: iostat -x.
Check for I/O bottlenecks, such as high wait times.
Unable to Unmount a File System

Symptom: umount command fails.
Troubleshooting:
Find processes using the mount point: lsof | grep <mount-point>.
Kill the processes or move them off the mount point.
Logs and Monitoring Issues
Log File Growing Too Large

Symptom: Log file consumes excessive disk space.
Troubleshooting:
Rotate logs using logrotate.
Configure log retention policies to limit log size.
Missing or Stale Logs

Symptom: Logs are not updating.
Troubleshooting:
Ensure logging service is running.
Check file permissions and disk space availability.
Restart the logging service if necessary.
Docker and Kubernetes Issues
Docker Container Fails to Start

Symptom: Container crashes immediately.
Troubleshooting:
Check container logs: docker logs <container-id>.
Inspect the Dockerfile or entrypoint for errors.
Restart the container with proper settings.
Kubernetes Pod CrashLoopBackOff

Symptom: Pod continually restarts.
Troubleshooting:
Get pod logs: kubectl logs <pod-name>.
Check deployment and environment variables for issues.
Increase pod resources if necessary.
Container Networking Issues

Symptom: Containers cannot communicate with each other.
Troubleshooting:
Verify network policies and ensure that containers are in the correct network.
Use docker network inspect or kubectl describe networkpolicies.
Kubernetes Node Not Ready

Symptom: Node is in NotReady state.
Troubleshooting:
Check node logs: journalctl -u kubelet.
Ensure the node has enough CPU and memory resources.
Restart kubelet or the node if necessary.
CI/CD Pipeline Issues
Build Fails in CI/CD Pipeline

Symptom: CI/CD pipeline build errors.
Troubleshooting:
Check the build logs for specific error messages.
Ensure build dependencies are correctly configured.
Artifacts Not Deployed Correctly

Symptom: Artifacts are not appearing in the target environment.
Troubleshooting:
Check deployment logs.
Ensure that the artifact repository and versioning are properly configured.
Slow CI/CD Pipeline

Symptom: Pipelines take too long to complete.
Troubleshooting:
Analyze bottlenecks in build and test stages.
Optimize caching and parallelization in pipeline configuration.
Security Issues
Unauthorized Access Attempts

Symptom: Multiple failed SSH login attempts.
Troubleshooting:
Check /var/log/auth.log or /var/log/secure.
Use fail2ban or configure firewall rules to block malicious IPs.
SSL Certificate Expired

Symptom: HTTPS sites are showing security errors.
Troubleshooting:
Renew the SSL certificate and update the web server configuration.
Reload or restart the web service.
General Troubleshooting
Slow Application Response

Symptom: Application is slow to respond.
Troubleshooting:
Check system resource utilization (top, free -m).
Monitor application logs for errors or slow queries.
Service Fails After Upgrade

Symptom: Service stops working after a software update.
Troubleshooting:
Roll back to the previous version.
Check for configuration changes required for the new version.