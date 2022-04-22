 -*- coding: utf-8 -*-
# Description: python.d plugin for Pathfinder, A starknet node
# Author: odyslam
# SPDX-License-Identifier: GPL-3.0-or-later

from random import SystemRandom
from bases.FrameworkServices.SimpleService import SimpleService
import requests

priority = 90000

ORDER = [
    'random',
]

CHARTS = {
    'random': {
        'options': [None, 'A random number', 'random number', 'random', 'random', 'line'],
        'lines': [
            ['random1']
        ]
    }
}


class Service(SimpleService):
    def __init__(self, configuration=None, name=None):
        SimpleService.__init__(self, configuration=configuration, name=name)
        self.order = ORDER
        self.definitions = CHARTS
        self.random = SystemRandom()
        self.um_lines = self.configuration.get('num_lines', 4)
        self.lower = self.configuration.get('lower', 0)
        self.upper = self.configuration.get('upper', 100)

    @staticmethod
    def check():
        return True

    def get_data(self):
        data = dict()
        requests.get(f'{self.rpc_endpoint}

        for i in range(0, self.num_lines):
            dimension_id = ''.join(['random', str(i)])

            if dimension_id not in self.charts['random']:
                self.charts['random'].add_dimension([dimension_id])

            data[dimension_id] = self.random.randint(self.lower, self.upper)

        return datan
