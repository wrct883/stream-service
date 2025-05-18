import subprocess
import time

def stream():
    rtpdump_command = ["rtpdump", "-F", "payload", "0xefc01b59/5004"]
    sox_command = [
        "sox", "-q", "-c", "2", "-r", "48000", "-b", "24", "-e", "signed-integer",
        "-B", "-t", "raw", "-", "-t", "mp3", "-", "gain", "5"
    ]
    ezstream_command = ["ezstream", "-c", "/home/wrct/stream/ezstream-stdin.xml"]

    rtpdump_process = subprocess.Popen(rtpdump_command, stdout=subprocess.PIPE)
    sox_process = subprocess.Popen(sox_command, stdin=rtpdump_process.stdout, stdout=subprocess.PIPE)
    ezstream_process = subprocess.Popen(ezstream_command, stdin=sox_process.stdout)

    return [ rtpdump_process, sox_process, ezstream_process ]

def killall(processes):
    for process in processes:
        if process.poll() is None:
            process.terminate()

def isup(processes):
    for process in processes:
        if process.poll() is not None:
            return True
    return False

while True:
    processes = stream()

    while True:
        if (isup(processes)):
            print("One of the processes has exited. Restarting the stream...")
            killall(processes)
            break

        time.sleep(5)

    time.sleep(5)
