describe('Visit Home Page', () => {

  it('should visit the home page', () => {
    cy.visit('/');
  });
  
  it("should increase cart count when product is added", () => {
    //see initial cart count 0
    cy.get('.nav-link').contains(' My Cart (0) ');
    //add product
    cy.get(".products article").first().find("button.btn").click({force: true});
    cy.get('.nav-link').contains(' My Cart (1) ').click();
    //confirm updated count
    cy.get('.cart-show div table tbody tr td').contains('1');
  });
    
});