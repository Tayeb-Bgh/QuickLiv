const cloudinary = require('cloudinary').v2;
require("dotenv").config();

cloudinary.config({ 
        cloud_name: "dj6wpivpf", 
        api_key: process.env.CLOUDINARY_API_KEY, 
        api_secret: process.env.CLOUDINARY_API_SECRET,

       /*  secure:true  */
});

/* (async function () {
  const results = await cloudinary.uploader.upload("../../../logo-search-grid-1x.png");
  console.log(results);
})();
 */


const url = cloudinary.url("cld-sample",{
    transformation:[
        {
            quality:"auto"
        },
        {
            fetch_format:"auto"
        }
    ]
});
console.log(url)