from ligotools import readligo as rl
import pytest
import numpy as np
import json

# Read the data
fnjson = "data/BBH_events_v3.json"
events = json.load(open(fnjson,"r"))
eventname = 'GW150914'
event = events[eventname]
fn_H1 = event['fn_H1']
fn_L1 = event['fn_L1']
strain_H1, time_H1, chan_dict_H1 = rl.loaddata('data/'+fn_H1, 'H1')
strain_L1, time_L1, chan_dict_L1 = rl.loaddata('data/'+fn_L1, 'L1')
strain, gpsStart, ts, qmask, shortnameList, injmask, injnameList = rl.read_hdf5("data/H-H1_LOSC_4_V2-1126259446-32.hdf5")

def test_loaddata1():
    assert isinstance(strain_H1, np.ndarray)
    assert isinstance(time_H1, np.ndarray)
    assert isinstance(chan_dict_H1, dict)
    
def test_loaddata2():
    assert isinstance(strain_L1, np.ndarray)
    assert isinstance(time_L1, np.ndarray)
    assert isinstance(chan_dict_L1, dict)
    
def test_hdf5():
    assert strain != 0
    
def test_hdf52():
    assert gpsStart != None


test_loaddata1()
test_loaddata2()
test_hdf5()
test_hdf52()