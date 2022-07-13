fortunesController = require("../controllers/fortunesController");

exports.appRoute = router => {
    router.get("/fortunes",fortunesController.getfortuneController)
}