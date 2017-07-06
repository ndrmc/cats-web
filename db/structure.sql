--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    code integer,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: adjustments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE adjustments (
    id integer NOT NULL,
    stock_take_id integer NOT NULL,
    stock_take_item_id integer NOT NULL,
    commodity_id integer NOT NULL,
    commodity_category_id integer NOT NULL,
    amount numeric NOT NULL,
    adjustment_type integer NOT NULL,
    reason character varying,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: adjustments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE adjustments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adjustments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE adjustments_id_seq OWNED BY adjustments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bid_plan_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bid_plan_items (
    id integer NOT NULL,
    bid_plan_id integer,
    woreda_id integer,
    store_id integer,
    quantity numeric,
    unit_of_measure_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: bid_plan_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bid_plan_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bid_plan_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bid_plan_items_id_seq OWNED BY bid_plan_items.id;


--
-- Name: bid_plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bid_plans (
    id integer NOT NULL,
    year character varying NOT NULL,
    half_year integer,
    program_id integer,
    code character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: bid_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bid_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bid_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bid_plans_id_seq OWNED BY bid_plans.id;


--
-- Name: bid_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bid_submissions (
    id integer NOT NULL,
    bid_id integer,
    transporter_id integer,
    bid_bond_amount numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: bid_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bid_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bid_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bid_submissions_id_seq OWNED BY bid_submissions.id;


--
-- Name: bid_winners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bid_winners (
    id integer NOT NULL,
    bid_id integer,
    transporter_id integer,
    store_id integer,
    destination_id integer,
    tariff_amount numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: bid_winners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bid_winners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bid_winners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bid_winners_id_seq OWNED BY bid_winners.id;


--
-- Name: bids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bids (
    id integer NOT NULL,
    bid_no character varying NOT NULL,
    start_date date,
    end_date date,
    description text,
    opening_date date,
    status integer DEFAULT 0 NOT NULL,
    bid_plan_id integer,
    region_id integer,
    document_price numeric,
    cpo_deposit_amount numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: bids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bids_id_seq OWNED BY bids.id;


--
-- Name: commodities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commodities (
    id integer NOT NULL,
    name character varying NOT NULL,
    name_am character varying,
    long_name character varying,
    code character varying NOT NULL,
    code_am character varying,
    description text,
    hazardous boolean,
    cold_storage boolean,
    min_temperature double precision,
    max_temperature double precision,
    commodity_category_id integer,
    uom_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: commodities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE commodities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commodities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE commodities_id_seq OWNED BY commodities.id;


--
-- Name: commodity_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commodity_categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    code_am character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    uom_category_id integer
);


--
-- Name: commodity_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE commodity_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commodity_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE commodity_categories_id_seq OWNED BY commodity_categories.id;


--
-- Name: commodity_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commodity_sources (
    id integer NOT NULL,
    name character varying,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: commodity_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE commodity_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commodity_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE commodity_sources_id_seq OWNED BY commodity_sources.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contracts (
    id integer NOT NULL,
    contract_no character varying NOT NULL,
    transport_id integer,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contracts_id_seq OWNED BY contracts.id;


--
-- Name: contributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contributions (
    id integer NOT NULL,
    donor_id integer,
    contribution_type integer,
    amount numeric,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    hrd_id integer,
    pledged_date timestamp without time zone
);


--
-- Name: contributions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contributions_id_seq OWNED BY contributions.id;


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE currencies (
    id integer NOT NULL,
    name character varying NOT NULL,
    symbol character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE currencies_id_seq OWNED BY currencies.id;


--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveries (
    id integer NOT NULL,
    receiving_number character varying NOT NULL,
    transporter_id integer NOT NULL,
    fdp_id integer NOT NULL,
    gin_number integer NOT NULL,
    requisition_number character varying NOT NULL,
    received_by character varying NOT NULL,
    received_date date NOT NULL,
    status integer,
    operation_id integer,
    remark text,
    draft boolean,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    delivery_id_guid character varying,
    received_date_ec character varying
);


--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveries_id_seq OWNED BY deliveries.id;


--
-- Name: delivery_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE delivery_details (
    id integer NOT NULL,
    commodity_id integer,
    uom_id integer,
    sent_quantity numeric,
    received_quantity numeric,
    delivery_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    guid_ref_delivery_id character varying
);


--
-- Name: delivery_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_details_id_seq OWNED BY delivery_details.id;


--
-- Name: delivery_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE delivery_imports (
    id integer NOT NULL,
    transporter_ref_no character varying,
    grn character varying,
    requisition_no character varying,
    received_by character varying,
    received_date character varying,
    delivery_date character varying,
    quantity_received_qtl character varying,
    prepared_date character varying,
    prepared_by character varying,
    gin character varying,
    dispatch_date character varying,
    region character varying,
    origin_warehouse character varying,
    zone character varying,
    woreda character varying,
    destination character varying,
    allocation_month character varying,
    allocation_year character varying,
    round character varying,
    program character varying,
    commodity_type character varying,
    sub_commodity character varying,
    unit_type character varying,
    allocation_quantity character varying,
    dispatch_quantity character varying,
    donor character varying,
    si_number character varying,
    transporter_name character varying,
    plate_no character varying,
    trailer_no character varying,
    driver_license character varying,
    hub_storekeeper character varying,
    project_code character varying,
    ltcd_no character varying,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    imported boolean
);


--
-- Name: delivery_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_imports_id_seq OWNED BY delivery_imports.id;


--
-- Name: department_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE department_permissions (
    id integer NOT NULL,
    department_id integer,
    permission_id integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: department_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE department_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: department_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE department_permissions_id_seq OWNED BY department_permissions.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE departments (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: dispatch_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dispatch_items (
    id integer NOT NULL,
    dispatch_id integer,
    commodity_category_id integer,
    commodity_id integer,
    quantity numeric,
    project_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    guid_ref character varying,
    organization_id integer,
    unit_of_measure_id integer
);


--
-- Name: dispatch_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dispatch_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dispatch_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dispatch_items_id_seq OWNED BY dispatch_items.id;


--
-- Name: dispatches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dispatches (
    id integer NOT NULL,
    gin_no character varying NOT NULL,
    operation_id integer,
    requisition_number character varying,
    dispatch_date timestamp without time zone,
    fdp_id integer,
    weight_bridge_ticket_number character varying,
    transporter_id integer,
    plate_number character varying,
    trailer_plate_number character varying,
    drivers_name character varying,
    remark text,
    draft boolean DEFAULT false,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    hub_id integer,
    warehouse_id integer,
    storekeeper_name character varying(200) NOT NULL,
    dispatch_id_guid character varying,
    dispatched_date_ec character varying
);


--
-- Name: fdps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fdps (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    lat numeric(15,13),
    lon numeric(15,13),
    active boolean,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    address character varying,
    woreda character varying,
    zone character varying,
    region character varying
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE locations (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying,
    location_type integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    parent_node_id integer
);


--
-- Name: requisition_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE requisition_items (
    id integer NOT NULL,
    requisition_id integer,
    fdp_id integer,
    beneficiary_no integer NOT NULL,
    amount numeric NOT NULL,
    contingency numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: requisitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE requisitions (
    id integer NOT NULL,
    requisition_no character varying NOT NULL,
    operation_id integer,
    commodity_id integer,
    region_id integer,
    zone_id integer,
    ration_id integer,
    requested_by character varying,
    requested_on date,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    request_id integer NOT NULL
);


--
-- Name: dispatch_summary_by_fdps; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW dispatch_summary_by_fdps AS
 SELECT allo.fdp_id AS allo_fdp,
    allo.operation_id AS allo_op_id,
    allo.commodity_id AS allo_comm_id,
    allo.commodity_name,
    allo.allocated,
    allo.requisition_no AS allo_req_no,
    disp.fdp_id AS disp_fdp,
    disp.operation_id AS dis_op_id,
    disp.commodity_id AS disp_comm_id,
    disp.dispatched,
    disp.requisition_number AS disp_req_no,
    allo.fdp_name,
    allo.woreda_id,
    allo.woreda_name,
    allo.zone_id,
    allo.zone_name,
    allo.region_id,
    allo.region_name
   FROM (( SELECT abs(sum(requisition_items.amount)) AS allocated,
            requisitions.operation_id,
            requisitions.commodity_id,
            requisition_items.fdp_id,
            requisitions.requisition_no,
            commodities.name AS commodity_name,
            fdps.name AS fdp_name,
            woreda.id AS woreda_id,
            woreda.name AS woreda_name,
            zone.id AS zone_id,
            zone.name AS zone_name,
            region.id AS region_id,
            region.name AS region_name
           FROM ((((((requisitions
             LEFT JOIN requisition_items ON ((requisitions.id = requisition_items.requisition_id)))
             LEFT JOIN commodities ON ((requisitions.commodity_id = commodities.id)))
             LEFT JOIN fdps ON ((requisition_items.fdp_id = fdps.id)))
             LEFT JOIN locations woreda ON ((fdps.location_id = woreda.id)))
             LEFT JOIN locations zone ON ((woreda.parent_node_id = zone.id)))
             LEFT JOIN locations region ON ((zone.parent_node_id = region.id)))
          GROUP BY requisitions.operation_id, requisitions.commodity_id, requisition_items.fdp_id, requisitions.requisition_no, fdps.name, woreda.id, woreda.name, zone.id, zone.name, region.id, region.name, commodities.name) allo
     LEFT JOIN ( SELECT abs(sum(d_items.quantity)) AS dispatched,
            dispatches.fdp_id,
            dispatches.operation_id,
            d_items.commodity_id,
            commodities.name AS commodity_name,
            dispatches.requisition_number
           FROM ((((((dispatch_items d_items
             LEFT JOIN dispatches ON ((d_items.dispatch_id = dispatches.id)))
             LEFT JOIN commodities ON ((d_items.commodity_id = commodities.id)))
             LEFT JOIN fdps ON ((dispatches.fdp_id = fdps.id)))
             LEFT JOIN locations woreda ON ((fdps.location_id = woreda.id)))
             LEFT JOIN locations zone ON ((woreda.parent_node_id = zone.id)))
             LEFT JOIN locations region ON ((zone.parent_node_id = region.id)))
          GROUP BY dispatches.fdp_id, dispatches.operation_id, d_items.commodity_id, commodities.name, dispatches.requisition_number) disp ON (((allo.fdp_id = disp.fdp_id) AND (allo.operation_id = disp.operation_id) AND (allo.commodity_id = disp.commodity_id) AND ((allo.requisition_no)::text = (disp.requisition_number)::text))));


--
-- Name: dispatches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dispatches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dispatches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dispatches_id_seq OWNED BY dispatches.id;


--
-- Name: donors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE donors (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    responsible boolean,
    source boolean,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: donors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE donors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: donors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE donors_id_seq OWNED BY donors.id;


--
-- Name: etl_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE etl_tasks (
    id integer NOT NULL,
    name character varying NOT NULL,
    executed boolean,
    executed_at timestamp without time zone,
    description text,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: etl_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE etl_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: etl_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE etl_tasks_id_seq OWNED BY etl_tasks.id;


--
-- Name: fdp_contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fdp_contacts (
    id integer NOT NULL,
    full_name character varying NOT NULL,
    mobile character varying,
    email character varying,
    fdp_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: fdp_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fdp_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fdp_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fdp_contacts_id_seq OWNED BY fdp_contacts.id;


--
-- Name: fdps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fdps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fdps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fdps_id_seq OWNED BY fdps.id;


--
-- Name: fscd_annual_plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fscd_annual_plans (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying,
    year character varying,
    duration integer,
    status integer DEFAULT 0 NOT NULL,
    archive boolean,
    ration_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: fscd_annual_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fscd_annual_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fscd_annual_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fscd_annual_plans_id_seq OWNED BY fscd_annual_plans.id;


--
-- Name: fscd_plan_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fscd_plan_items (
    id integer NOT NULL,
    beneficiary_no integer NOT NULL,
    fscd_annual_plan_id integer,
    woreda_id integer NOT NULL,
    starting_month integer,
    food_ratio integer,
    cash_ratio integer,
    contingency boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: fscd_plan_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fscd_plan_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fscd_plan_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fscd_plan_items_id_seq OWNED BY fscd_plan_items.id;


--
-- Name: fund_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fund_sources (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: fund_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fund_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fund_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fund_sources_id_seq OWNED BY fund_sources.id;


--
-- Name: fund_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fund_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: fund_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fund_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fund_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fund_types_id_seq OWNED BY fund_types.id;


--
-- Name: gift_certificates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gift_certificates (
    id integer NOT NULL,
    reference_no character varying NOT NULL,
    gift_date date,
    vessel character varying,
    organization_id integer,
    eta date,
    program_id integer,
    mode_of_transport_id integer,
    port_name character varying,
    status integer DEFAULT 0 NOT NULL,
    customs_declaration_no character varying,
    purchase_year character varying,
    expiry_date date,
    fund_type_id integer,
    account_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    bill_of_loading character varying,
    amount numeric(15,2),
    estimated_price numeric(15,2),
    estimated_tax numeric(15,2),
    fund_source_id integer,
    currency_id integer,
    commodity_id integer
);


--
-- Name: gift_certificates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gift_certificates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gift_certificates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gift_certificates_id_seq OWNED BY gift_certificates.id;


--
-- Name: git_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE git_imports (
    id integer NOT NULL,
    gin character varying,
    hub character varying,
    requisition_no character varying,
    round character varying,
    region character varying,
    zone character varying,
    woreda character varying,
    fdp character varying,
    transporter character varying,
    driver character varying,
    plat_no character varying,
    trailer_no character varying,
    dispatch_date character varying,
    project_code character varying,
    commodity_class character varying,
    commodity_type character varying,
    rounded_allocation_mt character varying,
    total_units_dispatched character varying,
    quintals_dispatched character varying,
    mt_dispatched character varying,
    allocation_period character varying,
    storekeeper character varying,
    store_no character varying,
    remark character varying,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    imported boolean
);


--
-- Name: git_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE git_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: git_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE git_imports_id_seq OWNED BY git_imports.id;


--
-- Name: grn_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE grn_imports (
    id integer NOT NULL,
    hub character varying,
    warehouse character varying,
    storekeeper character varying,
    received_date character varying,
    donor character varying,
    supplier character varying,
    origin character varying,
    si_donor character varying,
    project_code character varying,
    grn character varying,
    waybill_no character varying,
    commodity_class character varying,
    commodity_type character varying,
    total_units_received character varying,
    unit_weight character varying,
    sent_mt character varying,
    received_in_bag character varying,
    received_in_mt character varying,
    vessel_name character varying,
    transporter_name character varying,
    plat_no character varying,
    trailer_no character varying,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    commodity_source character varying,
    imported boolean
);


--
-- Name: grn_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grn_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grn_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grn_imports_id_seq OWNED BY grn_imports.id;


--
-- Name: hrd_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hrd_items (
    id integer NOT NULL,
    hrd_id integer,
    woreda_id integer,
    duration integer,
    starting_month integer,
    beneficiary integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    region_id integer,
    zone_id integer
);


--
-- Name: hrd_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hrd_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hrd_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hrd_items_id_seq OWNED BY hrd_items.id;


--
-- Name: hrds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hrds (
    id integer NOT NULL,
    year_gc integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    month_from integer,
    duration integer,
    season_id integer,
    ration_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    year_ec integer
);


--
-- Name: hrds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hrds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hrds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hrds_id_seq OWNED BY hrds.id;


--
-- Name: hubs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hubs (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    lat numeric(15,13),
    lon numeric(15,13),
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    address character varying
);


--
-- Name: hubs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hubs_id_seq OWNED BY hubs.id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE journals (
    id integer NOT NULL,
    name character varying,
    description character varying,
    code integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE journals_id_seq OWNED BY journals.id;


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: mode_of_transports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mode_of_transports (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: mode_of_transports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mode_of_transports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mode_of_transports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mode_of_transports_id_seq OWNED BY mode_of_transports.id;


--
-- Name: operations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE operations (
    id integer NOT NULL,
    program_id integer,
    hrd_id integer,
    fscd_annual_plan_id integer,
    name character varying NOT NULL,
    descripiton text,
    year character varying,
    round integer,
    month integer,
    expected_start date,
    expected_end date,
    actual_start date,
    actual_end date,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    ration_id integer
);


--
-- Name: operations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: operations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE operations_id_seq OWNED BY operations.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying NOT NULL,
    long_name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: ownership_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ownership_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ownership_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ownership_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ownership_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ownership_types_id_seq OWNED BY ownership_types.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE permissions (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: posting_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE posting_items (
    id integer NOT NULL,
    posting_item_code uuid,
    posting_id integer,
    account_id integer,
    journal_id integer,
    donor_id integer,
    hub_id integer,
    warehouse_id integer,
    store_id integer,
    stack_id integer,
    project_id integer,
    batch_id integer,
    program_id integer,
    operation_id integer,
    commodity_id integer,
    commodity_category_id integer,
    quantity numeric,
    region_id integer,
    zone_id integer,
    woreda_id integer,
    fdp_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: posting_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posting_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posting_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posting_items_id_seq OWNED BY posting_items.id;


--
-- Name: postings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE postings (
    id integer NOT NULL,
    posting_code uuid,
    document_type integer,
    document_id integer,
    posted boolean,
    reversed_posting_id integer,
    posting_type integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: postings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE postings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE postings_id_seq OWNED BY postings.id;


--
-- Name: programs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE programs (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE programs_id_seq OWNED BY programs.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE projects (
    id integer NOT NULL,
    project_code character varying,
    commodity_id integer,
    commodity_source_id integer,
    organization_id integer,
    amount numeric,
    unit_of_measure_id integer,
    publish_date date,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    old_id integer,
    reference_no character varying,
    si_id integer,
    si_value text,
    draft boolean DEFAULT false,
    archived boolean,
    commodity_categories_id integer
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: psnp_plan_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE psnp_plan_items (
    id integer NOT NULL,
    psnp_plan_id integer,
    woreda_id integer,
    duration integer,
    starting_month integer,
    beneficiary integer,
    region_id integer,
    zone_id integer,
    cash_ratio integer,
    kind_ratio integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: psnp_plan_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE psnp_plan_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: psnp_plan_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE psnp_plan_items_id_seq OWNED BY psnp_plan_items.id;


--
-- Name: psnp_plans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE psnp_plans (
    id integer NOT NULL,
    year_gc integer NOT NULL,
    year_ec integer,
    status integer DEFAULT 0 NOT NULL,
    month_from integer,
    duration integer,
    ration_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: psnp_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE psnp_plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: psnp_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE psnp_plans_id_seq OWNED BY psnp_plans.id;


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE quotations (
    id integer NOT NULL,
    bid_submission_id integer,
    store_id integer,
    destination_id integer,
    tariff_quote numeric,
    remark text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: quotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotations_id_seq OWNED BY quotations.id;


--
-- Name: ration_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ration_items (
    id integer NOT NULL,
    amount numeric NOT NULL,
    ration_id integer,
    unit_of_measure_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    commodity_id integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: ration_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ration_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ration_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ration_items_id_seq OWNED BY ration_items.id;


--
-- Name: rations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rations (
    id integer NOT NULL,
    reference_no character varying NOT NULL,
    description character varying,
    current boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: rations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rations_id_seq OWNED BY rations.id;


--
-- Name: receipt_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE receipt_lines (
    id integer NOT NULL,
    receipt_id integer,
    commodity_category_id integer,
    commodity_id integer,
    quantity numeric,
    project_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    unit_of_measure_id integer,
    receive_id character varying(36) NOT NULL,
    receive_item_id character varying(36) NOT NULL
);


--
-- Name: receipt_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receipt_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipt_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receipt_lines_id_seq OWNED BY receipt_lines.id;


--
-- Name: receipt_lines_temp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE receipt_lines_temp (
    id integer NOT NULL,
    receipt_id integer,
    commodity_category_id integer,
    commodity_id integer,
    quantity numeric,
    project_id integer,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    unit_of_measure_id integer,
    receive_id character varying(36) NOT NULL,
    receive_item_id character varying(36) NOT NULL,
    project_name character varying,
    si_value character varying
);


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE receipts (
    id integer NOT NULL,
    grn_no character varying NOT NULL,
    received_date timestamp without time zone,
    hub_id integer,
    warehouse_id integer,
    delivered_by character varying,
    supplier_id integer,
    transporter_id integer,
    plate_no character varying,
    trailer_plate_no character varying,
    weight_bridge_ticket_no character varying,
    weight_before_unloading numeric,
    weight_after_unloading numeric,
    storekeeper_name character varying,
    waybill_no character varying,
    purchase_request_no character varying,
    purchase_order_no character varying,
    invoice_no character varying,
    commodity_source_id integer,
    program_id integer,
    store_id integer,
    drivers_name character varying,
    remark text,
    draft boolean DEFAULT false,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    receiveid character varying(36) NOT NULL,
    received_date_ec character varying,
    donor_id integer
);


--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receipts_id_seq OWNED BY receipts.id;


--
-- Name: regional_request_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regional_request_items (
    id integer NOT NULL,
    regional_request_id integer,
    fdp_id integer,
    number_of_beneficiaries numeric,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: regional_request_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regional_request_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regional_request_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regional_request_items_id_seq OWNED BY regional_request_items.id;


--
-- Name: regional_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE regional_requests (
    id integer NOT NULL,
    operation_id integer,
    reference_number character varying,
    region_id integer,
    ration_id integer,
    requested_date timestamp without time zone,
    program_id integer,
    remark text,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    generated boolean
);


--
-- Name: regional_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regional_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regional_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regional_requests_id_seq OWNED BY regional_requests.id;


--
-- Name: requisition_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requisition_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requisition_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requisition_items_id_seq OWNED BY requisition_items.id;


--
-- Name: requisitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE requisitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: requisitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE requisitions_id_seq OWNED BY requisitions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying,
    created_by integer,
    modified_by integer,
    resource_type character varying,
    resource_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: seasons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE seasons (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    month_from integer,
    month_to integer
);


--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seasons_id_seq OWNED BY seasons.id;


--
-- Name: stock_take_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stock_take_items (
    id integer NOT NULL,
    commodity_id integer NOT NULL,
    commodity_category_id integer NOT NULL,
    theoretical_amount numeric NOT NULL,
    actual_amount numeric NOT NULL,
    stock_take_id integer NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    donor_id integer NOT NULL,
    project_id integer
);


--
-- Name: stock_take_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_take_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_take_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_take_items_id_seq OWNED BY stock_take_items.id;


--
-- Name: stock_takes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stock_takes (
    id integer NOT NULL,
    hub_id integer NOT NULL,
    warehouse_id integer NOT NULL,
    store_no integer,
    date date NOT NULL,
    fiscal_period integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    draft boolean DEFAULT true,
    title character varying NOT NULL
);


--
-- Name: stock_takes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_takes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_takes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_takes_id_seq OWNED BY stock_takes.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stores (
    id integer NOT NULL,
    name character varying NOT NULL,
    temporary boolean,
    warehouse_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    store_keeper_name character varying
);


--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stores_id_seq OWNED BY stores.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE suppliers (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE suppliers_id_seq OWNED BY suppliers.id;


--
-- Name: transport_order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transport_order_items (
    id integer NOT NULL,
    transport_order_id integer,
    fdp_id integer,
    store_id integer,
    commodity_id integer,
    quantity numeric,
    unit_of_measure_id integer,
    tariff numeric,
    requisition_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: transport_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transport_order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transport_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transport_order_items_id_seq OWNED BY transport_order_items.id;


--
-- Name: transport_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transport_orders (
    id integer NOT NULL,
    order_no character varying,
    transporter_id integer,
    contract_id integer,
    bid_id integer,
    operation_id integer,
    region_id integer,
    order_date date,
    created_date date,
    start_date date,
    end_date date,
    performance_bond_receipt character varying,
    performance_bond_amount numeric,
    printed_copies integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: transport_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transport_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transport_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transport_orders_id_seq OWNED BY transport_orders.id;


--
-- Name: transport_requisition_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transport_requisition_items (
    id integer NOT NULL,
    transport_requisition_item_id integer,
    requisition_no character varying,
    fdp_id integer,
    commodity_id integer,
    quantity numeric,
    has_transport_order boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: transport_requisition_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transport_requisition_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transport_requisition_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transport_requisition_items_id_seq OWNED BY transport_requisition_items.id;


--
-- Name: transport_requisitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transport_requisitions (
    id integer NOT NULL,
    region_id integer,
    operation_id integer,
    created_date date,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: transport_requisitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transport_requisitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transport_requisitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transport_requisitions_id_seq OWNED BY transport_requisitions.id;


--
-- Name: transporter_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transporter_addresses (
    id integer NOT NULL,
    transporter_id integer,
    region_id integer,
    city character varying,
    subcity character varying,
    kebele character varying,
    house_no character varying,
    phone character varying,
    mobile character varying,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: transporter_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transporter_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transporter_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transporter_addresses_id_seq OWNED BY transporter_addresses.id;


--
-- Name: transporters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transporters (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    vehicle_count integer,
    lift_capacity numeric,
    capital numeric,
    employees integer,
    contact character varying,
    contact_phone character varying,
    remark text,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    ownership_type_id integer
);


--
-- Name: transporters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transporters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transporters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transporters_id_seq OWNED BY transporters.id;


--
-- Name: unit_of_measures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE unit_of_measures (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    code character varying NOT NULL,
    uom_type integer DEFAULT 0 NOT NULL,
    ratio numeric(8,2) NOT NULL,
    uom_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: unit_of_measures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE unit_of_measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_of_measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE unit_of_measures_id_seq OWNED BY unit_of_measures.id;


--
-- Name: uom_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE uom_categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone
);


--
-- Name: uom_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uom_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uom_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uom_categories_id_seq OWNED BY uom_categories.id;


--
-- Name: user_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_types (
    id integer NOT NULL,
    name character varying,
    description character varying,
    created_by integer,
    modified_by integer,
    deleted boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_types_id_seq OWNED BY user_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    language character varying,
    keyboard character varying,
    calendar character varying,
    default_uom character varying,
    organization_unit character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    is_active boolean DEFAULT true,
    first_name character varying,
    last_name character varying,
    date_preference date,
    mobile_no character varying,
    number_of_logins integer,
    region_user boolean,
    user_types integer,
    location_id integer,
    hub_id integer,
    department_id integer
);


--
-- Name: users_departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users_departments (
    id integer NOT NULL,
    user_id integer,
    department_id integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_departments_id_seq OWNED BY users_departments.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users_permissions (
    id integer NOT NULL,
    user_id integer,
    permission_id integer,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_permissions_id_seq OWNED BY users_permissions.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users_roles (
    created_by integer,
    modified_by integer,
    user_id integer,
    role_id integer,
    deleted_at timestamp without time zone
);


--
-- Name: warehouses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE warehouses (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    hub_id integer,
    location_id integer,
    organization_id integer,
    lat numeric(15,13),
    lon numeric(15,13),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    modified_by integer,
    deleted_at timestamp without time zone,
    address character varying
);


--
-- Name: warehouses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warehouses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warehouses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warehouses_id_seq OWNED BY warehouses.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY adjustments ALTER COLUMN id SET DEFAULT nextval('adjustments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_plan_items ALTER COLUMN id SET DEFAULT nextval('bid_plan_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_plans ALTER COLUMN id SET DEFAULT nextval('bid_plans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_submissions ALTER COLUMN id SET DEFAULT nextval('bid_submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_winners ALTER COLUMN id SET DEFAULT nextval('bid_winners_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bids ALTER COLUMN id SET DEFAULT nextval('bids_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodities ALTER COLUMN id SET DEFAULT nextval('commodities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodity_categories ALTER COLUMN id SET DEFAULT nextval('commodity_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodity_sources ALTER COLUMN id SET DEFAULT nextval('commodity_sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contracts ALTER COLUMN id SET DEFAULT nextval('contracts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributions ALTER COLUMN id SET DEFAULT nextval('contributions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY currencies ALTER COLUMN id SET DEFAULT nextval('currencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries ALTER COLUMN id SET DEFAULT nextval('deliveries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_details ALTER COLUMN id SET DEFAULT nextval('delivery_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_imports ALTER COLUMN id SET DEFAULT nextval('delivery_imports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY department_permissions ALTER COLUMN id SET DEFAULT nextval('department_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatch_items ALTER COLUMN id SET DEFAULT nextval('dispatch_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatches ALTER COLUMN id SET DEFAULT nextval('dispatches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY donors ALTER COLUMN id SET DEFAULT nextval('donors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY etl_tasks ALTER COLUMN id SET DEFAULT nextval('etl_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fdp_contacts ALTER COLUMN id SET DEFAULT nextval('fdp_contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fdps ALTER COLUMN id SET DEFAULT nextval('fdps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fscd_annual_plans ALTER COLUMN id SET DEFAULT nextval('fscd_annual_plans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fscd_plan_items ALTER COLUMN id SET DEFAULT nextval('fscd_plan_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fund_sources ALTER COLUMN id SET DEFAULT nextval('fund_sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fund_types ALTER COLUMN id SET DEFAULT nextval('fund_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gift_certificates ALTER COLUMN id SET DEFAULT nextval('gift_certificates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_imports ALTER COLUMN id SET DEFAULT nextval('git_imports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grn_imports ALTER COLUMN id SET DEFAULT nextval('grn_imports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hrd_items ALTER COLUMN id SET DEFAULT nextval('hrd_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hrds ALTER COLUMN id SET DEFAULT nextval('hrds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hubs ALTER COLUMN id SET DEFAULT nextval('hubs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY journals ALTER COLUMN id SET DEFAULT nextval('journals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mode_of_transports ALTER COLUMN id SET DEFAULT nextval('mode_of_transports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY operations ALTER COLUMN id SET DEFAULT nextval('operations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ownership_types ALTER COLUMN id SET DEFAULT nextval('ownership_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posting_items ALTER COLUMN id SET DEFAULT nextval('posting_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY postings ALTER COLUMN id SET DEFAULT nextval('postings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY programs ALTER COLUMN id SET DEFAULT nextval('programs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY psnp_plan_items ALTER COLUMN id SET DEFAULT nextval('psnp_plan_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY psnp_plans ALTER COLUMN id SET DEFAULT nextval('psnp_plans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotations ALTER COLUMN id SET DEFAULT nextval('quotations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ration_items ALTER COLUMN id SET DEFAULT nextval('ration_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rations ALTER COLUMN id SET DEFAULT nextval('rations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_lines ALTER COLUMN id SET DEFAULT nextval('receipt_lines_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts ALTER COLUMN id SET DEFAULT nextval('receipts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_request_items ALTER COLUMN id SET DEFAULT nextval('regional_request_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_requests ALTER COLUMN id SET DEFAULT nextval('regional_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisition_items ALTER COLUMN id SET DEFAULT nextval('requisition_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisitions ALTER COLUMN id SET DEFAULT nextval('requisitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons ALTER COLUMN id SET DEFAULT nextval('seasons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_take_items ALTER COLUMN id SET DEFAULT nextval('stock_take_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_takes ALTER COLUMN id SET DEFAULT nextval('stock_takes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stores ALTER COLUMN id SET DEFAULT nextval('stores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY suppliers ALTER COLUMN id SET DEFAULT nextval('suppliers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_order_items ALTER COLUMN id SET DEFAULT nextval('transport_order_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_orders ALTER COLUMN id SET DEFAULT nextval('transport_orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_requisition_items ALTER COLUMN id SET DEFAULT nextval('transport_requisition_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_requisitions ALTER COLUMN id SET DEFAULT nextval('transport_requisitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transporter_addresses ALTER COLUMN id SET DEFAULT nextval('transporter_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transporters ALTER COLUMN id SET DEFAULT nextval('transporters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY unit_of_measures ALTER COLUMN id SET DEFAULT nextval('unit_of_measures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uom_categories ALTER COLUMN id SET DEFAULT nextval('uom_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_types ALTER COLUMN id SET DEFAULT nextval('user_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_departments ALTER COLUMN id SET DEFAULT nextval('users_departments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_permissions ALTER COLUMN id SET DEFAULT nextval('users_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warehouses ALTER COLUMN id SET DEFAULT nextval('warehouses_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: adjustments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adjustments
    ADD CONSTRAINT adjustments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bid_plan_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_plan_items
    ADD CONSTRAINT bid_plan_items_pkey PRIMARY KEY (id);


--
-- Name: bid_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_plans
    ADD CONSTRAINT bid_plans_pkey PRIMARY KEY (id);


--
-- Name: bid_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_submissions
    ADD CONSTRAINT bid_submissions_pkey PRIMARY KEY (id);


--
-- Name: bid_winners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bid_winners
    ADD CONSTRAINT bid_winners_pkey PRIMARY KEY (id);


--
-- Name: bids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (id);


--
-- Name: commodities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodities
    ADD CONSTRAINT commodities_pkey PRIMARY KEY (id);


--
-- Name: commodity_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodity_categories
    ADD CONSTRAINT commodity_categories_pkey PRIMARY KEY (id);


--
-- Name: commodity_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodity_sources
    ADD CONSTRAINT commodity_sources_pkey PRIMARY KEY (id);


--
-- Name: contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributions
    ADD CONSTRAINT contributions_pkey PRIMARY KEY (id);


--
-- Name: currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);


--
-- Name: deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: delivery_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_details
    ADD CONSTRAINT delivery_details_pkey PRIMARY KEY (id);


--
-- Name: delivery_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_imports
    ADD CONSTRAINT delivery_imports_pkey PRIMARY KEY (id);


--
-- Name: department_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY department_permissions
    ADD CONSTRAINT department_permissions_pkey PRIMARY KEY (id);


--
-- Name: departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: dispatch_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatch_items
    ADD CONSTRAINT dispatch_items_pkey PRIMARY KEY (id);


--
-- Name: dispatches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatches
    ADD CONSTRAINT dispatches_pkey PRIMARY KEY (id);


--
-- Name: donors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY donors
    ADD CONSTRAINT donors_pkey PRIMARY KEY (id);


--
-- Name: etl_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY etl_tasks
    ADD CONSTRAINT etl_tasks_pkey PRIMARY KEY (id);


--
-- Name: fdp_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fdp_contacts
    ADD CONSTRAINT fdp_contacts_pkey PRIMARY KEY (id);


--
-- Name: fdps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fdps
    ADD CONSTRAINT fdps_pkey PRIMARY KEY (id);


--
-- Name: fscd_annual_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fscd_annual_plans
    ADD CONSTRAINT fscd_annual_plans_pkey PRIMARY KEY (id);


--
-- Name: fscd_plan_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fscd_plan_items
    ADD CONSTRAINT fscd_plan_items_pkey PRIMARY KEY (id);


--
-- Name: fund_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fund_sources
    ADD CONSTRAINT fund_sources_pkey PRIMARY KEY (id);


--
-- Name: fund_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fund_types
    ADD CONSTRAINT fund_types_pkey PRIMARY KEY (id);


--
-- Name: gift_certificates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gift_certificates
    ADD CONSTRAINT gift_certificates_pkey PRIMARY KEY (id);


--
-- Name: git_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY git_imports
    ADD CONSTRAINT git_imports_pkey PRIMARY KEY (id);


--
-- Name: grn_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY grn_imports
    ADD CONSTRAINT grn_imports_pkey PRIMARY KEY (id);


--
-- Name: hrd_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hrd_items
    ADD CONSTRAINT hrd_items_pkey PRIMARY KEY (id);


--
-- Name: hrds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hrds
    ADD CONSTRAINT hrds_pkey PRIMARY KEY (id);


--
-- Name: hubs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hubs
    ADD CONSTRAINT hubs_pkey PRIMARY KEY (id);


--
-- Name: journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mode_of_transports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mode_of_transports
    ADD CONSTRAINT mode_of_transports_pkey PRIMARY KEY (id);


--
-- Name: operations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: ownership_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ownership_types
    ADD CONSTRAINT ownership_types_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: posting_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY posting_items
    ADD CONSTRAINT posting_items_pkey PRIMARY KEY (id);


--
-- Name: postings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY postings
    ADD CONSTRAINT postings_pkey PRIMARY KEY (id);


--
-- Name: programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: psnp_plan_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY psnp_plan_items
    ADD CONSTRAINT psnp_plan_items_pkey PRIMARY KEY (id);


--
-- Name: psnp_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY psnp_plans
    ADD CONSTRAINT psnp_plans_pkey PRIMARY KEY (id);


--
-- Name: quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);


--
-- Name: ration_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ration_items
    ADD CONSTRAINT ration_items_pkey PRIMARY KEY (id);


--
-- Name: rations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rations
    ADD CONSTRAINT rations_pkey PRIMARY KEY (id);


--
-- Name: receipt_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_lines
    ADD CONSTRAINT receipt_lines_pkey PRIMARY KEY (id);


--
-- Name: receipt_lines_temp_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_lines_temp
    ADD CONSTRAINT receipt_lines_temp_pkey PRIMARY KEY (id);


--
-- Name: receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: regional_request_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_request_items
    ADD CONSTRAINT regional_request_items_pkey PRIMARY KEY (id);


--
-- Name: regional_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_requests
    ADD CONSTRAINT regional_requests_pkey PRIMARY KEY (id);


--
-- Name: requisition_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisition_items
    ADD CONSTRAINT requisition_items_pkey PRIMARY KEY (id);


--
-- Name: requisitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY requisitions
    ADD CONSTRAINT requisitions_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: stock_take_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_take_items
    ADD CONSTRAINT stock_take_items_pkey PRIMARY KEY (id);


--
-- Name: stock_takes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_takes
    ADD CONSTRAINT stock_takes_pkey PRIMARY KEY (id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: transport_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_order_items
    ADD CONSTRAINT transport_order_items_pkey PRIMARY KEY (id);


--
-- Name: transport_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_orders
    ADD CONSTRAINT transport_orders_pkey PRIMARY KEY (id);


--
-- Name: transport_requisition_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_requisition_items
    ADD CONSTRAINT transport_requisition_items_pkey PRIMARY KEY (id);


--
-- Name: transport_requisitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transport_requisitions
    ADD CONSTRAINT transport_requisitions_pkey PRIMARY KEY (id);


--
-- Name: transporter_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transporter_addresses
    ADD CONSTRAINT transporter_addresses_pkey PRIMARY KEY (id);


--
-- Name: transporters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transporters
    ADD CONSTRAINT transporters_pkey PRIMARY KEY (id);


--
-- Name: unit_of_measures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY unit_of_measures
    ADD CONSTRAINT unit_of_measures_pkey PRIMARY KEY (id);


--
-- Name: uom_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uom_categories
    ADD CONSTRAINT uom_categories_pkey PRIMARY KEY (id);


--
-- Name: user_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_types
    ADD CONSTRAINT user_types_pkey PRIMARY KEY (id);


--
-- Name: users_departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_departments
    ADD CONSTRAINT users_departments_pkey PRIMARY KEY (id);


--
-- Name: users_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_permissions
    ADD CONSTRAINT users_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_deleted_at ON accounts USING btree (deleted_at);


--
-- Name: index_accounts_on_name_and_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_name_and_code ON accounts USING btree (name, code);


--
-- Name: index_bid_plan_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bid_plan_items_on_deleted_at ON bid_plan_items USING btree (deleted_at);


--
-- Name: index_bid_plans_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bid_plans_on_deleted_at ON bid_plans USING btree (deleted_at);


--
-- Name: index_bid_submissions_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bid_submissions_on_deleted_at ON bid_submissions USING btree (deleted_at);


--
-- Name: index_bid_winners_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bid_winners_on_deleted_at ON bid_winners USING btree (deleted_at);


--
-- Name: index_bids_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bids_on_deleted_at ON bids USING btree (deleted_at);


--
-- Name: index_commodities_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commodities_on_code ON commodities USING btree (code);


--
-- Name: index_commodities_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commodities_on_deleted_at ON commodities USING btree (deleted_at);


--
-- Name: index_commodity_categories_on_ancestry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commodity_categories_on_ancestry ON commodity_categories USING btree (ancestry);


--
-- Name: index_commodity_categories_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commodity_categories_on_code ON commodity_categories USING btree (code);


--
-- Name: index_commodity_categories_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commodity_categories_on_deleted_at ON commodity_categories USING btree (deleted_at);


--
-- Name: index_commodity_categories_on_uom_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commodity_categories_on_uom_category_id ON commodity_categories USING btree (uom_category_id);


--
-- Name: index_contracts_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contracts_on_deleted_at ON contracts USING btree (deleted_at);


--
-- Name: index_contributions_on_donor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contributions_on_donor_id ON contributions USING btree (donor_id);


--
-- Name: index_contributions_on_hrd_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contributions_on_hrd_id ON contributions USING btree (hrd_id);


--
-- Name: index_currencies_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_currencies_on_deleted_at ON currencies USING btree (deleted_at);


--
-- Name: index_currencies_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_currencies_on_name ON currencies USING btree (name);


--
-- Name: index_deliveries_on_receiving_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_deliveries_on_receiving_number ON deliveries USING btree (receiving_number);


--
-- Name: index_department_permissions_on_department_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_department_permissions_on_department_id ON department_permissions USING btree (department_id);


--
-- Name: index_department_permissions_on_permission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_department_permissions_on_permission_id ON department_permissions USING btree (permission_id);


--
-- Name: index_dispatch_items_on_commodity_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatch_items_on_commodity_category_id ON dispatch_items USING btree (commodity_category_id);


--
-- Name: index_dispatch_items_on_commodity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatch_items_on_commodity_id ON dispatch_items USING btree (commodity_id);


--
-- Name: index_dispatch_items_on_dispatch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatch_items_on_dispatch_id ON dispatch_items USING btree (dispatch_id);


--
-- Name: index_dispatch_items_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatch_items_on_organization_id ON dispatch_items USING btree (organization_id);


--
-- Name: index_dispatch_items_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatch_items_on_project_id ON dispatch_items USING btree (project_id);


--
-- Name: index_dispatches_on_fdp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatches_on_fdp_id ON dispatches USING btree (fdp_id);


--
-- Name: index_dispatches_on_hub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatches_on_hub_id ON dispatches USING btree (hub_id);


--
-- Name: index_dispatches_on_operation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatches_on_operation_id ON dispatches USING btree (operation_id);


--
-- Name: index_dispatches_on_transporter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatches_on_transporter_id ON dispatches USING btree (transporter_id);


--
-- Name: index_dispatches_on_warehouse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dispatches_on_warehouse_id ON dispatches USING btree (warehouse_id);


--
-- Name: index_donors_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_donors_on_code ON donors USING btree (code);


--
-- Name: index_donors_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_donors_on_deleted_at ON donors USING btree (deleted_at);


--
-- Name: index_fdp_contacts_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fdp_contacts_on_deleted_at ON fdp_contacts USING btree (deleted_at);


--
-- Name: index_fdps_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fdps_on_deleted_at ON fdps USING btree (deleted_at);


--
-- Name: index_fscd_annual_plans_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fscd_annual_plans_on_deleted_at ON fscd_annual_plans USING btree (deleted_at);


--
-- Name: index_fscd_annual_plans_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_fscd_annual_plans_on_year ON fscd_annual_plans USING btree (year);


--
-- Name: index_fscd_plan_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fscd_plan_items_on_deleted_at ON fscd_plan_items USING btree (deleted_at);


--
-- Name: index_fund_sources_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fund_sources_on_deleted_at ON fund_sources USING btree (deleted_at);


--
-- Name: index_fund_sources_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_fund_sources_on_name ON fund_sources USING btree (name);


--
-- Name: index_fund_types_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fund_types_on_deleted_at ON fund_types USING btree (deleted_at);


--
-- Name: index_fund_types_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_fund_types_on_name ON fund_types USING btree (name);


--
-- Name: index_gift_certificates_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gift_certificates_on_deleted_at ON gift_certificates USING btree (deleted_at);


--
-- Name: index_gift_certificates_on_reference_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_gift_certificates_on_reference_no ON gift_certificates USING btree (reference_no);


--
-- Name: index_hrd_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hrd_items_on_deleted_at ON hrd_items USING btree (deleted_at);


--
-- Name: index_hrds_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hrds_on_deleted_at ON hrds USING btree (deleted_at);


--
-- Name: index_hrds_on_year_gc_and_season_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_hrds_on_year_gc_and_season_id ON hrds USING btree (year_gc, season_id);


--
-- Name: index_hubs_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hubs_on_deleted_at ON hubs USING btree (deleted_at);


--
-- Name: index_hubs_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_hubs_on_name ON hubs USING btree (name);


--
-- Name: index_locations_on_ancestry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_ancestry ON locations USING btree (ancestry);


--
-- Name: index_locations_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_deleted_at ON locations USING btree (deleted_at);


--
-- Name: index_mode_of_transports_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mode_of_transports_on_deleted_at ON mode_of_transports USING btree (deleted_at);


--
-- Name: index_mode_of_transports_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_mode_of_transports_on_name ON mode_of_transports USING btree (name);


--
-- Name: index_operations_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_operations_on_deleted_at ON operations USING btree (deleted_at);


--
-- Name: index_organizations_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_deleted_at ON organizations USING btree (deleted_at);


--
-- Name: index_programs_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_programs_on_code ON programs USING btree (code);


--
-- Name: index_programs_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_programs_on_deleted_at ON programs USING btree (deleted_at);


--
-- Name: index_projects_on_commodity_categories_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_commodity_categories_id ON projects USING btree (commodity_categories_id);


--
-- Name: index_projects_on_project_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_project_code ON projects USING btree (project_code);


--
-- Name: index_psnp_plans_on_year_gc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_psnp_plans_on_year_gc ON psnp_plans USING btree (year_gc);


--
-- Name: index_quotations_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quotations_on_deleted_at ON quotations USING btree (deleted_at);


--
-- Name: index_ration_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ration_items_on_deleted_at ON ration_items USING btree (deleted_at);


--
-- Name: index_rations_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rations_on_deleted_at ON rations USING btree (deleted_at);


--
-- Name: index_rations_on_reference_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_rations_on_reference_no ON rations USING btree (reference_no);


--
-- Name: index_receipt_lines_on_commodity_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipt_lines_on_commodity_category_id ON receipt_lines USING btree (commodity_category_id);


--
-- Name: index_receipt_lines_on_commodity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipt_lines_on_commodity_id ON receipt_lines USING btree (commodity_id);


--
-- Name: index_receipt_lines_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipt_lines_on_project_id ON receipt_lines USING btree (project_id);


--
-- Name: index_receipt_lines_on_receipt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipt_lines_on_receipt_id ON receipt_lines USING btree (receipt_id);


--
-- Name: index_receipt_lines_on_unit_of_measure_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipt_lines_on_unit_of_measure_id ON receipt_lines USING btree (unit_of_measure_id);


--
-- Name: index_receipts_on_commodity_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_commodity_source_id ON receipts USING btree (commodity_source_id);


--
-- Name: index_receipts_on_hub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_hub_id ON receipts USING btree (hub_id);


--
-- Name: index_receipts_on_program_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_program_id ON receipts USING btree (program_id);


--
-- Name: index_receipts_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_store_id ON receipts USING btree (store_id);


--
-- Name: index_receipts_on_supplier_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_supplier_id ON receipts USING btree (supplier_id);


--
-- Name: index_receipts_on_transporter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_transporter_id ON receipts USING btree (transporter_id);


--
-- Name: index_receipts_on_warehouse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_warehouse_id ON receipts USING btree (warehouse_id);


--
-- Name: index_regional_request_items_on_fdp_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_regional_request_items_on_fdp_id ON regional_request_items USING btree (fdp_id);


--
-- Name: index_regional_request_items_on_regional_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_regional_request_items_on_regional_request_id ON regional_request_items USING btree (regional_request_id);


--
-- Name: index_regional_requests_on_operation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_regional_requests_on_operation_id ON regional_requests USING btree (operation_id);


--
-- Name: index_regional_requests_on_program_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_regional_requests_on_program_id ON regional_requests USING btree (program_id);


--
-- Name: index_regional_requests_on_ration_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_regional_requests_on_ration_id ON regional_requests USING btree (ration_id);


--
-- Name: index_requisition_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_requisition_items_on_deleted_at ON requisition_items USING btree (deleted_at);


--
-- Name: index_requisitions_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_requisitions_on_deleted_at ON requisitions USING btree (deleted_at);


--
-- Name: index_requisitions_on_requisition_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_requisitions_on_requisition_no ON requisitions USING btree (requisition_no);


--
-- Name: index_roles_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_deleted_at ON roles USING btree (deleted_at);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_seasons_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_seasons_on_deleted_at ON seasons USING btree (deleted_at);


--
-- Name: index_seasons_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_seasons_on_name ON seasons USING btree (name);


--
-- Name: index_stores_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_deleted_at ON stores USING btree (deleted_at);


--
-- Name: index_stores_on_name_and_warehouse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stores_on_name_and_warehouse_id ON stores USING btree (name, warehouse_id);


--
-- Name: index_transport_order_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transport_order_items_on_deleted_at ON transport_order_items USING btree (deleted_at);


--
-- Name: index_transport_orders_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transport_orders_on_deleted_at ON transport_orders USING btree (deleted_at);


--
-- Name: index_transport_requisition_items_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transport_requisition_items_on_deleted_at ON transport_requisition_items USING btree (deleted_at);


--
-- Name: index_transport_requisitions_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transport_requisitions_on_deleted_at ON transport_requisitions USING btree (deleted_at);


--
-- Name: index_transporter_addresses_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transporter_addresses_on_deleted_at ON transporter_addresses USING btree (deleted_at);


--
-- Name: index_transporters_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transporters_on_deleted_at ON transporters USING btree (deleted_at);


--
-- Name: index_unit_of_measures_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_unit_of_measures_on_code ON unit_of_measures USING btree (code);


--
-- Name: index_unit_of_measures_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_unit_of_measures_on_deleted_at ON unit_of_measures USING btree (deleted_at);


--
-- Name: index_uom_categories_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uom_categories_on_deleted_at ON uom_categories USING btree (deleted_at);


--
-- Name: index_users_departments_on_department_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_departments_on_department_id ON users_departments USING btree (department_id);


--
-- Name: index_users_departments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_departments_on_user_id ON users_departments USING btree (user_id);


--
-- Name: index_users_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_deleted_at ON users USING btree (deleted_at);


--
-- Name: index_users_on_department_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_department_id ON users USING btree (department_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_hub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_hub_id ON users USING btree (hub_id);


--
-- Name: index_users_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_location_id ON users USING btree (location_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_permissions_on_permission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_permissions_on_permission_id ON users_permissions USING btree (permission_id);


--
-- Name: index_users_permissions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_permissions_on_user_id ON users_permissions USING btree (user_id);


--
-- Name: index_users_roles_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_deleted_at ON users_roles USING btree (deleted_at);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: index_warehouses_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_warehouses_on_deleted_at ON warehouses USING btree (deleted_at);


--
-- Name: fk_rails_015d52b0b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_requests
    ADD CONSTRAINT fk_rails_015d52b0b3 FOREIGN KEY (ration_id) REFERENCES rations(id);


--
-- Name: fk_rails_0d298d8e8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commodity_categories
    ADD CONSTRAINT fk_rails_0d298d8e8d FOREIGN KEY (uom_category_id) REFERENCES uom_categories(id);


--
-- Name: fk_rails_0f498e4d8f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_requests
    ADD CONSTRAINT fk_rails_0f498e4d8f FOREIGN KEY (operation_id) REFERENCES operations(id);


--
-- Name: fk_rails_148027514b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY department_permissions
    ADD CONSTRAINT fk_rails_148027514b FOREIGN KEY (department_id) REFERENCES departments(id);


--
-- Name: fk_rails_1db25c9dd0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_request_items
    ADD CONSTRAINT fk_rails_1db25c9dd0 FOREIGN KEY (fdp_id) REFERENCES fdps(id);


--
-- Name: fk_rails_3d8a7b9295; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_permissions
    ADD CONSTRAINT fk_rails_3d8a7b9295 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_43eff0f43c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT fk_rails_43eff0f43c FOREIGN KEY (commodity_categories_id) REFERENCES commodity_categories(id);


--
-- Name: fk_rails_441e8da8fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_permissions
    ADD CONSTRAINT fk_rails_441e8da8fa FOREIGN KEY (permission_id) REFERENCES permissions(id);


--
-- Name: fk_rails_487bad179a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatches
    ADD CONSTRAINT fk_rails_487bad179a FOREIGN KEY (warehouse_id) REFERENCES warehouses(id);


--
-- Name: fk_rails_794d965170; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributions
    ADD CONSTRAINT fk_rails_794d965170 FOREIGN KEY (hrd_id) REFERENCES hrds(id);


--
-- Name: fk_rails_7fb1ef0ef0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY department_permissions
    ADD CONSTRAINT fk_rails_7fb1ef0ef0 FOREIGN KEY (permission_id) REFERENCES permissions(id);


--
-- Name: fk_rails_84b3bbe1e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatches
    ADD CONSTRAINT fk_rails_84b3bbe1e2 FOREIGN KEY (hub_id) REFERENCES hubs(id);


--
-- Name: fk_rails_a8b50e88f4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributions
    ADD CONSTRAINT fk_rails_a8b50e88f4 FOREIGN KEY (donor_id) REFERENCES donors(id);


--
-- Name: fk_rails_ab2dca4d42; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_request_items
    ADD CONSTRAINT fk_rails_ab2dca4d42 FOREIGN KEY (regional_request_id) REFERENCES regional_requests(id);


--
-- Name: fk_rails_b917af0f43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_departments
    ADD CONSTRAINT fk_rails_b917af0f43 FOREIGN KEY (department_id) REFERENCES departments(id);


--
-- Name: fk_rails_cbafd1e5ff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_departments
    ADD CONSTRAINT fk_rails_cbafd1e5ff FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_ccd20a034b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipt_lines
    ADD CONSTRAINT fk_rails_ccd20a034b FOREIGN KEY (unit_of_measure_id) REFERENCES unit_of_measures(id);


--
-- Name: fk_rails_dcf00b8406; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regional_requests
    ADD CONSTRAINT fk_rails_dcf00b8406 FOREIGN KEY (program_id) REFERENCES programs(id);


--
-- Name: fk_rails_e6776c9318; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dispatch_items
    ADD CONSTRAINT fk_rails_e6776c9318 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20160808082438'),
('20160808082723'),
('20160808090529'),
('20160808090602'),
('20160808093211'),
('20160808100046'),
('20160808151143'),
('20160808151439'),
('20160808152307'),
('20160808152502'),
('20160808153624'),
('20160808154034'),
('20160808192300'),
('20160809061822'),
('20160809064026'),
('20160810072707'),
('20160810074815'),
('20160810075016'),
('20160810115913'),
('20160810120826'),
('20160810122741'),
('20160810123720'),
('20160810124617'),
('20160810125525'),
('20160810130407'),
('20160810130932'),
('20160810131927'),
('20160810133453'),
('20160810142033'),
('20160810143320'),
('20160810144217'),
('20160811143051'),
('20160812075632'),
('20160812075948'),
('20160812082711'),
('20160812083027'),
('20160812083148'),
('20160812085510'),
('20160812085520'),
('20160812085540'),
('20160812091204'),
('20160812091438'),
('20160812115005'),
('20160812115821'),
('20160812120458'),
('20161113182319'),
('20161115124421'),
('20161115124518'),
('20161117095946'),
('20161118143002'),
('20161121060232'),
('20161121060536'),
('20161121061437'),
('20161121081010'),
('20161121083334'),
('20161121090258'),
('20161128112900'),
('20161130074356'),
('20161201063253'),
('20161205141834'),
('20170203064423'),
('20170203073504'),
('20170203074515'),
('20170203074847'),
('20170207103027'),
('20170207103030'),
('20170208122119'),
('20170208123024'),
('20170213125937'),
('20170213130319'),
('20170213141922'),
('20170214153319'),
('20170214155919'),
('20170214161019'),
('20170216115642'),
('20170216120028'),
('20170216125240'),
('20170222120558'),
('20170222183759'),
('20170222184133'),
('20170223053930'),
('20170226064916'),
('20170226153058'),
('20170301145258'),
('20170301145658'),
('20170301150658'),
('20170309101930'),
('20170309113320'),
('20170309152300'),
('20170310094210'),
('20170313085125'),
('20170313092407'),
('20170315072023'),
('20170315072655'),
('20170315081020'),
('20170316082211'),
('20170318103755'),
('20170320050407'),
('20170320051844'),
('20170322110528'),
('20170322110633'),
('20170322133007'),
('20170322184115'),
('20170323072956'),
('20170323090521'),
('20170325094952'),
('20170325120145'),
('20170325120808'),
('20170327072202'),
('20170328133734'),
('20170329081608'),
('20170329124823'),
('20170330091608'),
('20170330104338'),
('20170418063919'),
('20170418064710'),
('20170418065241'),
('20170424143500'),
('20170425060632'),
('20170428130940'),
('20170509120116'),
('20170510120632'),
('20170511150828'),
('20170523061130'),
('20170523061219'),
('20170524075102'),
('20170524111751'),
('20170526013937'),
('20170529081913'),
('20170530055949'),
('20170530062714'),
('20170530093653'),
('20170609060605'),
('20170609102301'),
('20170609102318'),
('20170613110106'),
('20170613124910'),
('20170616084451'),
('20170616084718'),
('20170704061342'),
('20170704130414');


