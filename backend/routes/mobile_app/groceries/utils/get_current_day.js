const dayMap = {
    0: 1, 
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 7
  };
  

const getAssciatedDayNumber = ()=>{

    const today = new Date();
    const dayOfWeek = today.getDay(); // 0 (Sun) to 6 (Sat)
    const associatedNumber = dayMap[dayOfWeek];
    
    return associatedNumber  
}

module.exports = getAssciatedDayNumber;