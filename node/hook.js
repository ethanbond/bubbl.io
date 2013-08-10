var gith = require('gith').create(9001);
var execFile = require('child_process').execFile;

gith({
        repo: 'ethanbond/bubbl.io'
}).on('all', function(payload){
        if(payload.branch === 'master'){
        	execFile('`whoami`');
                // execFile('~/hooks/bubbl.io/hook.sh', function(error, stdout, stderr){
                //         console.log('Received webhook from ethanbond/bubbl.io/master');
                // });
        }
});