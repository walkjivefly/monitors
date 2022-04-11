#!/usr/bin/python3
# Name: cpprice
# Purpose: this is a sample XCloud service plugin which gets the current 
#          price of a specified coin in a specified fiat currency using
#          the CoinPaprika API as wrapped by 
#          https://github.com/s0h3ck/coinpaprika-api-python-client
#
# Usage: cpprice [coin] [currency]
# 
#        [coin] is best specified as a ticker symbol, eg: BTC
#               If not specified, or empty, it defaults to BLOCK.
#        [currency] may be another coin or a fiat currency.
#               If not specified, or empty, it defaults to USD.
#
# Licence: MIT License
# Copyright (c) 2021 Mark Brooker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

import sys
from coinpaprika import client as Coinpaprika
client = Coinpaprika.Client()

if len(sys.argv) == 1:
    coin = 'BLOCK'
    currency = 'USD'
elif len(sys.argv) == 2:
    coin = sys.argv[1]
    currency = 'USD'
else:
    coin = sys.argv[1]
    currency = sys.argv[2].upper()
    if currency not in ('BTC', 'ETH', 'USD', 'EUR', 'PLN', 'KRW', 'GBP', 
                        'CAD', 'JPY', 'RUB', 'TRY', 'NZD', 'AUD', 'CHF', 
                        'UAH', 'HKD', 'SGD', 'NGN', 'PHP', 'MXN', 'BRL', 
                        'THB', 'CLP', 'CNY', 'CZK', 'DKK', 'HUF', 'IDR', 
                        'ILS', 'INR', 'MYR', 'NOK', 'PKR', 'SEK', 'TWD', 
                        'ZAR', 'VND', 'BOB', 'COP', 'PEN', 'ARS', 'ISK'):
        currency = 'USD'

coins = client.coins()
key = 'unsupported'
for t in coins:
    if t['symbol'] == coin:
        key = t['id']
        break
    elif t['id'] == coin:
        key = t['id']
        break
    elif t['name'] == coin:
        key = t['id']
        break
if key == 'unsupported':
    key = 'block-blocknet'
try:
    price = client.ticker(key, quotes=currency)
    print(price['quotes'][currency]['price'])
except:
    print('exception encountered')
