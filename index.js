//Imports
const express = require('express')
const Shell = require('node-powershell');

//initialize a shell instance
const ps = new Shell({
    executionPolicy: 'Bypass',
    noProfile: true
});

//Setup and configure app
const app = express()
const port = 5000

//route request
app.use('/', (req, res) => {
    ps.addCommand(`Get-Process | ConvertTo-JSON `);
    ps.invoke()
        .then(response => {
	   // console.log(response)
            res.send(response)
        })
        .catch(err => {
            res.json(err)
	    console.log(err);
            ps.dispose();
        });
});

//Initialize app
app.listen(port, () => console.log(`Server listening on port ${port}!`))
