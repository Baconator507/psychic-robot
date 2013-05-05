#!/usr/bin/python
from multiprocessing import Pool, Value
import subprocess
import sys
import time

counter = None
trials = int(sys.argv[1])

def init(args):
    ''' store the counter for later use '''
    global counter
    counter = args

def clisp(x):
  global counter
  done = 0
  while (done < trials/4):
    p = subprocess.Popen("clisp game.lisp", stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    try:
      jose = output.split(':')[2].split(' ')[3] #assuming jose is always at position 3
      if (jose == '40000'):
        counter.value += 1
        done += 1
    except:
      continue

if __name__ == '__main__':
    # initialize a cross-process counter and the input lists
    counter = Value('i', 0)
    inputs = [1, 2, 3, 4] #4 threads

    # create the pool of workers, ensuring each one receives the counter 
    start = time.time()
    p = Pool(initializer = init, initargs = (counter, ))
    i = p.map_async(clisp, inputs, chunksize = 1)
    i.wait()
    print "done in %d seconds" % (time.time() - start)
    print "jose win ration: %0.2f" % ((counter.value/float(trials)) * 100)

