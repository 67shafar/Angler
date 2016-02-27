Feature: Website Navigation
	As a guest
	In order to navigate website pages
	I should be able to click on navigation links

	Scenario Outline: Going to a page
		Given I am on the website
		When I click on the <page> link
		Then the page title should be <title>

		Examples:
			|     page      	|        title          		  |
			|  "Our Story"  	|  "AnglerCupOfJoe - Our Story"   |
			|  "Menu" 			|  "AnglerCupOfJoe - Menu" 	 	  |
			|  "Reservations"   |  "AnglerCupOfJoe - Reservations"|
			|  "Reviews"   		|  "AnglerCupOfJoe - Reviews" 	  |