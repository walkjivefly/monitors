#!/usr/bin/python3
# Name: yfprice
# Purpose: this is a sample XCloud service plugin which gets the current 
#          price of a specified asset using the Yahoo Finance API as wrapped
#          by https://github.com/ranaroussi/yfinance/releases/tag/0.1.55
# Usage: yfprice [asset]
# 
#        [asset] must be a valid Yahoo Finance id, eg: 
#                   GBPUSD=X   GBP/USD exchange rate
#                   EURGBP=X   EUR/GBP exchange rate
#                   IBM        IBM stock price
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
import yfinance as yf
from icecream import ic
info = yf.Ticker(sys.argv[1]).info
#ic(info)
try:
    if info['quoteType'] in ('EQUITY', 'ETF'):
        print(info['regularMarketPrice'])
    else:
        print(info['quoteType'])
except:
    print('Unknown symbol')
