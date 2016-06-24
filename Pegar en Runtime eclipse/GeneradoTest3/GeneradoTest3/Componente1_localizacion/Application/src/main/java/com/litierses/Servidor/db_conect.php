<?php

class DB_CONNECT {

    function __construct() {
        // connecting to database
        $this->connect();
    }

    function __destruct() {
        // closing db connection
        $this->close();
    }

    function connect() {
        // import database connection variables
        require_once('db_config.php');

        // Connecting to mysql database
        $con = mysql_connect(DB_SERVER, DB_USER, DB_PASSWORD) or die(mysql_error());

        // Selecing database
        $db = mysql_select_db(DB_DATABASE) or die(mysql_error()) or die(mysql_error());

        // returing connection cursor
        return $con;
    }

    /**
     * Function to close db connection
     */
    function close() {
        // closing db connection
        mysql_close();
    }

}

?>