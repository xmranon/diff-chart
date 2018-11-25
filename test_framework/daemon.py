# Copyright (c) 2018 The Monero Project
# 
# All rights reserved.


"""Daemon class to make rpc calls and store state."""

from .rpc import JSONRPC 

class Daemon(object):

    def __init__(self, protocol='http', host='127.0.0.1', port=17566):
        self.rpc = JSONRPC(protocol=protocol, host=host, port=port)

    def getblocktemplate(self, address):
        getblocktemplate = {
            'method': 'getblocktemplate',
            'params': {
                'wallet_address': address,
                'reserve_size' : 1
            },
            'jsonrpc': '2.0', 
            'id': '0'
        }
        return self.rpc.send_request('/json_rpc', getblocktemplate)

    def get_block_headers_range(self, start_height, end_height):
        get_block_headers_range = {
            'method': 'get_block_headers_range',
            'params': {
                'start_height': start_height,
                'end_height' : end_height
            },
            'jsonrpc': '2.0',
            'id': '0'
        }
        return self.rpc.send_request('/json_rpc', get_block_headers_range)

    def submitblock(self, block):
        submitblock = {
            'method': 'submitblock',
            'params': [ block ],    
            'jsonrpc': '2.0', 
            'id': '0'
        }    
        return self.rpc.send_request('/json_rpc', submitblock)

    def getblock(self, height=0):
        getblock = {
            'method': 'getblock',
            'params': {
                'height': height
            },
            'jsonrpc': '2.0', 
            'id': '0'
        }
        return self.rpc.send_request('/json_rpc', getblock)

    def gettransactions(self, tx_hashes):
        gettransactions = {
            'txs_hashes': tx_hashes,
            'decode_as_json': True,
            'prune': True
        }
        return self.rpc.send_request('/gettransactions', gettransactions)

    def get_connections(self):
        get_connections = {
            'method': 'get_connections',
            'jsonrpc': '2.0', 
            'id': '0'
        }
        return self.rpc.send_request('/json_rpc', get_connections)

    def get_info(self):
        get_info = {
                'method': 'get_info',
                'jsonrpc': '2.0', 
                'id': '0'
        }    
        return self.rpc.send_request('/json_rpc', get_info)    

    def hard_fork_info(self):
        hard_fork_info = {
                'method': 'hard_fork_info',
                'jsonrpc': '2.0', 
                'id': '0'
        }    
        return self.rpc.send_request('/json_rpc', hard_fork_info)    

    def generateblocks(self, address, blocks=1):
        generateblocks = {
            'method': 'generateblocks',
            'params': {
                'amount_of_blocks' : blocks,
                'reserve_size' : 20,
                'wallet_address': address
            },
            'jsonrpc': '2.0', 
            'id': '0'
        }
        return self.rpc.send_request('/json_rpc', generateblocks)
