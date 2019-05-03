const moment = require('moment');
const fs = require('fs');
const _ = require('lodash');
const axios = require('axios');

const es = require('elasticsearch');
const client = new es.Client({host: 'https://sirenadmin:password@localhost:9220'})
