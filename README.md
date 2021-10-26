![image](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![image](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![image](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![RuboCop](https://img.shields.io/badge/code%20style-Rubocop-red?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAzMiAzMiI+PHRpdGxlPmZpbGVfdHlwZV9ydWJvY29wPC90aXRsZT48cGF0aCBkPSJNMjcuMDUsMTMuOVYxM2ExLjc5MywxLjc5MywwLDAsMC0xLjgtMS44SDYuNjVBMS43OTMsMS43OTMsMCwwLDAsNC44NSwxM3YuOWExLjUyNSwxLjUyNSwwLDAsMC0uNywxLjJ2Mi40YTEuMzg3LDEuMzg3LDAsMCwwLC43LDEuMnYuOWExLjc5MywxLjc5MywwLDAsMCwxLjgsMS44aDE4LjdhMS43OTMsMS43OTMsMCwwLDAsMS44LTEuOHYtLjlhMS41MjUsMS41MjUsMCwwLDAsLjctMS4yVjE1LjFBMS43NDIsMS43NDIsMCwwLDAsMjcuMDUsMTMuOVoiIHN0eWxlPSJmaWxsOiNjNWM1YzUiLz48cGF0aCBkPSJNMTUuOTUsMmE5LjkyNSw5LjkyNSwwLDAsMC05LjgsOC42aDE5LjZBOS45MjUsOS45MjUsMCwwLDAsMTUuOTUsMloiIHN0eWxlPSJmaWxsOiNjNWM1YzUiLz48cG9seWdvbiBwb2ludHM9IjEzLjA1IDI0IDE4Ljg1IDI0IDE5LjQ1IDI0LjcgMjAuMzUgMjQgMTkuNDUgMjIuOSAxMi40NSAyMi45IDExLjU1IDI0IDEyLjQ1IDI0LjcgMTMuMDUgMjQiIHN0eWxlPSJmaWxsOiNjNWM1YzUiLz48cGF0aCBkPSJNMjMuNTUsMTcuNkg4LjM1YTEuMywxLjMsMCwxLDEsMC0yLjZoMTUuM2ExLjMyNCwxLjMyNCwwLDAsMSwxLjMsMS4zQTEuNDkzLDEuNDkzLDAsMCwxLDIzLjU1LDE3LjZaIiBzdHlsZT0iZmlsbDojZWMxYzI0Ii8+PHBhdGggZD0iTTIzLjA1LDIydjMuOGExLjk2NywxLjk2NywwLDAsMS0xLjksMS45aC0xYS44NjQuODY0LDAsMCwxLS42LS4zbC0xLjItMS42YS42LjYsMCwwLDAtLjYtLjNoLTMuNmEuNzY0Ljc2NCwwLDAsMC0uNS4ybC0xLjMsMS42YS42LjYsMCwwLDEtLjYuM2gtMWExLjk2NywxLjk2NywwLDAsMS0xLjktMS45VjIySDYuNTV2My44YTQuMjI1LDQuMjI1LDAsMCwwLDQuMiw0LjJoMTAuNGE0LjIyNSw0LjIyNSwwLDAsMCw0LjItNC4yVjIyWiIgc3R5bGU9ImZpbGw6I2M1YzVjNSIvPjwvc3ZnPg==)


# Rails Engine
An API only application that serves as a backend for business intelligence. 

### Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes.

## Local Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:create`
4. Run migrations: ` rails db:migrate`

## Versions
* Ruby 2.7.2
* Rails 5.2.6

## Important Gems
Testing
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [simplecov](https://github.com/simplecov-ruby/simplecov)
* [pry](https://github.com/pry/pry)
* [json](https://github.com/flori/json)
* [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer)

## Running the tests

Run `bundle exec rspec` to run the test suite

## Endpoints Exposed

### Merchants

* Get all merchants, a maximum of 20 at a time

`GET /api/v1/merchants?per_page=3`

Response:

```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        },
        {
            "id": "3",
            "type": "merchant",
            "attributes": {
                "name": "Willms and Sons"
            }
        }
    ]
}
```

* Get one merchant

`GET /api/v1/merchants/42`

Response:

```
{
    "data": {
        "id": "42",
        "type": "merchant",
        "attributes": {
            "name": "Glover Inc"
        }
    }
}
```

* Get all items for a given merchant ID

`GET /api/v1/merchants/99/items`

Response:

```
{
    "data": [
        {
            "id": "2425",
            "type": "item",
            "attributes": {
                "name": "Item Excepturi Rem",
                "description": "Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.",
                "unit_price": 476.82,
                "merchant_id": 99
            }
        },
        {
            "id": "2438",
            "type": "item",
            "attributes": {
                "name": "Item Omnis Adipisci",
                "description": "Corporis dicta eaque qui dolor mollitia enim. Est est quas aut deleniti quam. Tempore alias velit laudantium eum ut rerum est. Eos quis sequi expedita. Laboriosam minima autem pariatur perferendis consequatur.",
                "unit_price": 672.53,
                "merchant_id": 99
            }
        }
    ]
}
```

### Items

* Get all items, a maximum of 20 at a time 
* Get one item
* Create an item
* Edit an item
* Delete an item
* Get the merchant data for a given item ID


### Business Intelligence 

* Get merchants with most revenue

`GET /api/v1/revenue/merchants?quantity=2`

Response:

```
{
    "data": [
        {
            "id": "14",
            "type": "merchant_name_revenue",
            "attributes": {
                "name": "Dicki-Bednar",
                "revenue": 1148393.7399999984
            }
        },
        {
            "id": "89",
            "type": "merchant_name_revenue",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon",
                "revenue": 1015275.1499999997
            }
        }
    ]
}
```

* Get merchants who sold most items

`GET /api/v1/merchants/most_items?quantity=2`

Response:

```
{
    "data": [
        {
            "id": "89",
            "type": "items_sold",
            "attributes": {
                "name": "Kassulke, O'Hara and Quitzon",
                "count": 1653
            }
        },
        {
            "id": "12",
            "type": "items_sold",
            "attributes": {
                "name": "Kozey Group",
                "count": 1585
            }
        }
    ]
}
```

* Get revenue of a single merchant

`GET /api/v1/revenue/merchants/42`

Response:

```
{
    "data": {
        "id": "42",
        "type": "merchant_revenue",
        "attributes": {
            "revenue": 532613.98
        }
    }
}
```

* Get potential revenue of unshipped orders

`GET /api/v1/revenue/unshipped`

Response:

```
{
    "data": [
        {
            "id": "4844",
            "type": "unshipped_order",
            "attributes": {
                "potential_revenue": 1504.08
            }
        }
    ]
}
```


## Contact

Zach Trokey [GitHub](https://github.com/ztrokey) • [LinkedIn](https://www.linkedin.com/in/zach-trokey/)
