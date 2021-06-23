({
  onLoad: function(component, event, helper) {
    console.log('colorCmp load');
    var classSchedule = component.get("v.colorClassCategory");
 
    if (classSchedule != undefined) {
      
      var tempLowerCase = classSchedule.toUpperCase();
      //var tempLowerCase = classSchedule.toLowerCase();
      var cOrange = 'EDUCATION FUND';
      var cRed = 'LA CARE (IHSS+)';
      var cYellow = 'CDPH/UCSF';
      var cLightGreen = 'IHSS+ A&D';
      
      if (cOrange.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'orange');
      } else if (cRed.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'Red');
      } else if (cYellow.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'Yellow');
      } else if (cLightGreen.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'LightGreen');
      }
    }
  },
})