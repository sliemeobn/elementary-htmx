actor BonusFactStore {
    // courtesy of chatchipitty
    let bonusFacts = [
        "Writing code is 10% typing and 90% figuring out why you typed it that way in the first place.",
        "The hardest part of programming isn't coding — it's naming variables without sounding ridiculous.",
        "If code comments are the breadcrumbs, then debugging is following a very messy trail of pizza crumbs.",
        "Optionals in Swift are a nice way of saying, 'Yeah, I have no idea what might happen here.'",
        "You can fix 99% of your bugs by turning it off and back on. The other 1%? Crying helps.",
        "Programmers don't sleep. They just enter a low-power mode with their eyes open.",
        "In the world of code, everything is either a `true`, `false`, or 'maybe, if you handle this optional safely.'",
        "Any code that hasn't been touched in more than six months is officially considered 'legacy code.'",
    ]

    func calculateBonusFact() async -> String {
        return bonusFacts.randomElement()!
    }

    @TaskLocal static var current: BonusFactStore?
}
