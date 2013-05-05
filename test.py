#!/usr/bin/python
from multiprocessing import Pool
import subprocess

def clisp(x):
  count = 0
  for i in range(10):
    p = subprocess.Popen("clisp game.lisp", stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    jose = output.split(':')[2].split(' ')[3]
    if (jose == '40000'):
       print str(i) + " jose WINS!"
       count = count + 1
    else:
       print str(i) + " jose didn't win"

  print "jose win ration: %0.2f" % ((count/10.0) * 100)

if __name__ == '__main__':
    pool = Pool(processes=4)             
    result = pool.map_async(clisp, range(4))
    result.get(timeout=10000) 
