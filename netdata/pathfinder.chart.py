# -*- coding: utf-8 -*-
# Description: python.d plugin for Pathfinder, A starknet node
# Author: odyslam
# SPDX-License-Identifier: GPL-3.0-or-later

from bases.FrameworkServices.SimpleService import SimpleService
import requests

NETDATA_UPDATE_EVERY=5
priority = 90000

ORDER = [
    'syncing',
    'block_number'
]

CHARTS = {
    'syncing': {
        'options': ['syncing', 'Starknet Node Syncing Status', 'bool', 'starknet', 'starknet', 'line'],
        'lines': [
            ['syncing', 'Syncing']
        ]
    },
    'block_number': {
        'options': ['block_number', "Block Number", 'blocks', 'starknet', 'starknet', 'area'],
        'lines': [
            ['block_number', 'Block']
            ]
        }
}

class Service(SimpleService):
    def __init__(self, configuration=None, name=None):
        SimpleService.__init__(self, configuration=configuration, name=name)
        self.order = ORDER
        self.definitions = CHARTS
        self.rpc_endpoint_url = self.configuration.get('rpc_endpoint_url', 'http://127.0.0.1')
        self.rpc_endpoint_port = self.configuration.get('rpc_endpoint_port', '9545')
        self.rpc_endpoint = f'{self.rpc_endpoint_url}:{self.rpc_endpoint_port}'

    @staticmethod
    def check():
        return True

    def payload(self, method, params):
        return { "jsonrpc": "2.0", "method": method, "params": params, "id": 0}

    def get_data(self):
        data = {}
        data['block_number'] = requests.post(self.rpc_endpoint, json = self.payload("starknet_blockNumber", [])).json()['result']
        data['syncing'] = 1 if requests.post(self.rpc_endpoint, json = self.payload("starknet_syncing", [])).json()['result'] == 'True' else 0
        return data
