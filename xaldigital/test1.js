const axios = require('axios');

var count_answered = 0;
var count_unanswered = 0;

var lowest_view_count = 0;
var lowest_view_id = 0;

var oldest_date = undefined;
var oldest_id = 0;

var newest_date = undefined;
var newest_id = 0;

var best_reputation = 0;
var owner = 0;

//Problema 1
axios.get('https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow')
.then(res => {
    res.data.items.forEach(item => {
        //Problema 2
        if(item.is_answered)
        {
            count_answered+=1;
        }
        else
        {
            count_unanswered+=1;
        }

        //Problema 3
        if(lowest_view_count == 0)
        {
            lowest_view_count = item.view_count;
            lowest_view_id = item.question_id;
        }
        else
        {
            if(item.view_count < lowest_view_count)
            {
                lowest_view_count = item.view_count;
                lowest_view_id = item.question_id;
            }
        }

        //Problema 4
        if(oldest_date == undefined)
        {
            oldest_date = item.creation_date;
            oldest_id = item.question_id;
        }
        else
        {
            if(item.creation_date < oldest_date)
            {
                oldest_date = item.creation_date;
                oldest_id = item.question_id;
            }
        }
        
        if(newest_date == undefined)
        {
            newest_date = item.creation_date;
            newest_id = item.question_id;
        }
        else
        {
            if(item.creation_date > newest_date)
            {
                newest_date = item.creation_date;
                newest_id = item.question_id;
            }
        }

        //Problema 5
        if(best_reputation == 0)
        {
            best_reputation = item.owner.reputation;
            owner = item.owner.user_id;
        }
        else
        {
            if(item.owner.reputation >= best_reputation)
            {
                best_reputation = item.owner.reputation;
                owner = item.owner.user_id;
            }
        }

    });
    console.log("Answered: "+count_answered);
    console.log("Unanswered: "+count_unanswered);
    console.log("Lowest View Question: "+lowest_view_id);
    console.log("Oldest Post: "+oldest_id);
    console.log("Newest Post: "+newest_id);
    console.log("Best Reputation: "+owner);
})
.catch(error => {
    console.error(error);
})