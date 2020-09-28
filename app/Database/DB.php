<?php
namespace Database;
use PDO;
class DB {
    public static $db;
    public static $dbname = "db_master2";
    public static $stmt;

    private $options = [
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ];

    public static function connect ($db) {
        $server = "mysql:host=".$db[0].";dbname=".$db[1].";charset=utf8mb4";
        try {
            self::$db = new PDO ($server, $db[2], $db[3], $options);
        } catch (PDOException $e) {
            return array ('error' => true, 'message' => "DB ERROR: Unable to connect to database. Please check and configure database connection to continue.", 'debug_message' => $e->getMessage());
        }
    }

    public static function fetch_all () {
        $result = self::execute (func_get_args ());
        if ($result) return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function fetch_row () {
        $result = self::execute (func_get_args ());
        if ($result) return $result->fetch(PDO::FETCH_ASSOC);
    }

    private static function execute ($args) {
        if (!self::$db) self::connect (['localhost', self::$dbname, 'root', 'password']);
        $args[1] = isset ($args[1]) ? is_array ($args[1]) ? $args[1] : [$args[1]] : []; // Convert vars to array IF NOT array
        try {
            if (!($query = self::$db->prepare($args[0]))) return;
            if (!($query->execute($args[1]))) return;
            return $query;
        } catch (PDOException $e) {
            return;
        }
        return null;
    }

    public static function insert () {
        self::execute (func_get_args ());
        return self::$db->lastInsertId();
    }

    public static function update () {
        return self::execute (func_get_args ());
    }

    public static function delete () {
        return self::execute (func_get_args ());
    }

    public static function db ($db) {
        self::$dbname = $db;
        return new self ();
    }

    public static function stmt_builder ($data) {
        self::$stmt = '';
        $i = count ($data);
        foreach ($data as $key => $value) {
            self::$stmt .= "$key = :$key";
            $i--;
            if ($i > 0){
                self::$stmt .= ", ";
            }
        }
        return self::$stmt;
    }
}