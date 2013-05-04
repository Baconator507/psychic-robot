#!/usr/bin/python
import subprocess
count = 0
for i in range(10):
  p = subprocess.Popen("clisp game.lisp", stdout=subprocess.PIPE, shell=True)
  (output, err) = p.communicate()
  jose = output.split(':')[2].split(' ')[3]
  if (jose == '40000'):
    print "jose WINS!"
    count = count + 1

print "jose win ration: %0.2f" % ((count/10.0) * 100)
