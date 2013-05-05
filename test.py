#!/usr/bin/python
from multiprocessing import Pool
import subprocess

def clisp():
  count = 0
  for i in range(100):
    p = subprocess.Popen("clisp game.lisp", stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    jose = output.split(':')[2].split(' ')[3]
    if (jose == '40000'):
       print str(i) + " jose WINS!"
       count = count + 1
    else:
       print str(i) + " jose didn't win"

  print "jose win ration: %0.2f" % ((count/100.0) * 100)

if __name__ == '__main__':
  clisp()
