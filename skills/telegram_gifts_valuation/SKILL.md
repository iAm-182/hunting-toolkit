# Telegram Gifts Valuation

## Confirm the currency unit first

- Ask which currency a price is in before you do any maths when the user gives a bare number.

- Treat Giftcoin as points inside @freegifts only and never convert Giftcoin to rupiah or TON or GRAM.

- Treat GRAM and TON as cash value and keep Stars separate because Stars convert at a lower rate than GRAM.

- Never compare a Giftcoin price with a cash floor or a cash price with a Giftcoin earning rate.

- Restate the price with its unit in your answer so the user can spot a wrong unit at once.

## Value the gift in cash terms

- Find the floor price for the same model in GRAM from a live market source and note the date and time of the quote.

- Compare the asking price with that floor only when both are in GRAM and state the ratio plainly.

- Weight trait rarity with model first and serial number last and say which traits explain a premium over floor.

- Say when a premium cannot be verified from floor data and ask the user to check comparable listings in the app.

## Judge farming value on the shelf

- Judge a gift by its permanent multiplier and its absolute earning per hour together because a large multiplier on a small base rate still earns little.

- Use a permanent multiplier of 4 or above as the usual bar for a farming buy and say when a gift falls below it.

- Work out payback in hours by dividing the Giftcoin price by the gift hourly earning in Giftcoin and by dividing the cash price by the cash value of its hourly earning when the price is cash.

- Never use a daily bonus gift as the benchmark for buying because its earning expires and it does not reflect permanent farming.

- Count collection chemistry by collection only and use 2 gifts for 1 diamond and plus 15 percent, 4 gifts for 2 diamonds and plus 35 percent, and 6 gifts for 3 diamonds and plus 60 percent with a full shelf bonus of plus 10 percent.

- Warn against splitting slots across three collections at 2 each because that gives only plus 15 percent on every gift.

## Check sellability before quoting cash

- Ask the user to check Telegram profile Gifts for the gift before you quote a sale price because a gift that lives only inside @freegifts cannot be sold for TON.

- Explain the sale route as gift to GRAM to rupiah and give the Telegram fee of 10 percent for GRAM and 20 percent for Stars and the Fragment fee of 5 percent plus about 1 GRAM network fee.

- Warn that selling or exporting a gift removes it from the shelf and stops its Giftcoin earning.

- Treat Giftcoin and any future airdrop as unconfirmed bonus only until an official announcement gives a token, a listing date and a claim method.

- Warn against anyone who offers to convert Giftcoin in a direct message and asks for a seed phrase, a one time code or an upfront fee.

## Available connectors

- Use `muse.connector_search` to find other connectors and `muse.skill_search` to find related skills.

- If nothing here fits, look on the web for a maintained API or MCP server and set it up with [Custom Connectors and MCPs](/opt/muse/skills/custom-connector-setup/SKILL.md), or build a custom connector.

## Websites

- [bubble.gifts](https://bubble.gifts/) for the floor price in GRAM, the 24 hour volume and the number of sales for a gift model. Carry the exact model and traits into `browser.browse` and verify the floor, the volume and the sale count there.

- [Fragment](https://fragment.com/) for selling a Telegram Gift as an NFT and for its fees. Carry the exact gift and the asking price into `browser.browse` and verify the fee and the net proceeds there.

- [Getgems](https://getgems.io/) for a second market price for a Telegram Gift NFT. Carry the exact gift into `browser.browse` and verify the listed price and the sale history there.

## Alternatives for better results

- Compare the gift with other gifts in the same collection before buying for chemistry because a lone gift earns no collection bonus.

- Wait for a listing closer to floor when the premium is for traits that do not raise hourly earning.

- Keep a gift that is already owned when selling would lose more in fees and lost earning than the sale would gain.
