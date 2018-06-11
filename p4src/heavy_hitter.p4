#define HH_LOAD_WIDTH       32
#define HH_LOAD_NUM         256
#define HH_LOAD_HASH_WIDTH  8
#define HH_THRESHOLD        128
#define HH_BF_NUM           512
#define HH_BF_HASH_WIDTH    9

header_type nc_load_md_t {
    bit<16> index_1;
    bit<16> index_2;
    bit<16> index_3;
    bit<16> index_4;
        
    bit<32> load_1;
    bit<32> load_2;
    bit<32> load_3;
    bit<32> load_4;
}
metadata nc_load_md_t nc_load_md;

field_list hh_hash_fields {
    nc_hdr.key;
}

Register<bit<HH_LOAD_WIDTH>>(HH_LOAD_NUM) hh_load_1_reg 

field_list_calculation hh_load_1_hash {
    input {
        hh_hash_fields;
    }
    algorithm : crc32;
    output_width : HH_LOAD_HASH_WIDTH;
}
action hh_load_1_count_act() {
    modify_field_with_hash_based_offset(nc_load_md.index_1, 0, hh_load_1_hash, HH_LOAD_NUM);
    register_read(nc_load_md.load_1, hh_load_1_reg, nc_load_md.index_1);
    register_write(hh_load_1_reg, nc_load_md.index_1, nc_load_md.load_1 + 1);
}
table hh_load_1_count {
    actions = {
        hh_load_1_count_act;
    }
}

Register<bit<HH_LOAD_WIDTH>>(HH_LOAD_NUM) hh_load_2_reg 

field_list_calculation hh_load_2_hash {
    input {
        hh_hash_fields;
    }
    algorithm : csum16;
    output_width : HH_LOAD_HASH_WIDTH;
}
action hh_load_2_count_act() {
    modify_field_with_hash_based_offset(nc_load_md.index_2, 0, hh_load_2_hash, HH_LOAD_NUM);
    register_read(nc_load_md.load_2, hh_load_2_reg, nc_load_md.index_2);
    register_write(hh_load_2_reg, nc_load_md.index_2, nc_load_md.load_2 + 1);
}
table hh_load_2_count {
    actions = {
        hh_load_2_count_act;
    }
}

Register<bit<HH_LOAD_WIDTH>>(HH_LOAD_NUM) hh_load_3_reg 

field_list_calculation hh_load_3_hash {
    input {
        hh_hash_fields;
    }
    algorithm : crc16;
    output_width : HH_LOAD_HASH_WIDTH;
}
action hh_load_3_count_act() {
    modify_field_with_hash_based_offset(nc_load_md.index_3, 0, hh_load_3_hash, HH_LOAD_NUM);
    register_read(nc_load_md.load_3, hh_load_3_reg, nc_load_md.index_3);
    register_write(hh_load_3_reg, nc_load_md.index_3, nc_load_md.load_3 + 1);
}
table hh_load_3_count {
    actions = {
        hh_load_3_count_act;
    }
}

Register<bit<HH_LOAD_WIDTH>>(HH_LOAD_NUM) hh_load_4_reg 

field_list_calculation hh_load_4_hash {
    input {
        hh_hash_fields;
    }
    algorithm : crc32;
    output_width : HH_LOAD_HASH_WIDTH;
}
action hh_load_4_count_act() {
    modify_field_with_hash_based_offset(nc_load_md.index_4, 0, hh_load_4_hash, HH_LOAD_NUM);
    register_read(nc_load_md.load_4, hh_load_4_reg, nc_load_md.index_4);
    register_write(hh_load_4_reg, nc_load_md.index_4, nc_load_md.load_4 + 1);
}
table hh_load_4_count {
    actions = {
        hh_load_4_count_act;
    }
}

control count_min {
    hh_load_1_count.apply();
    hh_load_2_count.apply();
    hh_load_3_count.apply();
    hh_load_4_count.apply();
}

header_type hh_bf_md_t {
    bit<16> index_1;
    bit<16> index_2;
    bit<16> index_3;

    bit<1> bf_1;
    bit<1> bf_2;
    bit<1> bf_3;
}
metadata hh_bf_md_t hh_bf_md;

Register<bit<1>>(HH_BF_NUM) hh_bf_1_reg 

field_list_calculation hh_bf_1_hash {
    input {
        hh_hash_fields;
    }
    algorithm : crc32;
    output_width : HH_BF_HASH_WIDTH;
}
action hh_bf_1_act() {
    modify_field_with_hash_based_offset(hh_bf_md.index_1, 0, hh_bf_1_hash, HH_BF_NUM);
    register_read(hh_bf_md.bf_1, hh_bf_1_reg, hh_bf_md.index_1);
    register_write(hh_bf_1_reg, hh_bf_md.index_1, 1);
}
table hh_bf_1 {
    actions = {
        hh_bf_1_act;
    }
}

Register<bit<1>>(HH_BF_NUM) hh_bf_2_reg 

field_list_calculation hh_bf_2_hash {
    input {
        hh_hash_fields;
    }
    algorithm : csum16;
    output_width : HH_BF_HASH_WIDTH;
}
action hh_bf_2_act() {
    modify_field_with_hash_based_offset(hh_bf_md.index_2, 0, hh_bf_2_hash, HH_BF_NUM);
    register_read(hh_bf_md.bf_2, hh_bf_2_reg, hh_bf_md.index_2);
    register_write(hh_bf_2_reg, hh_bf_md.index_2, 1);
}
table hh_bf_2 {
    actions = {
        hh_bf_2_act;
    }
}

Register<bit<1>>(HH_BF_NUM) hh_bf_3_reg 

field_list_calculation hh_bf_3_hash {
    input {
        hh_hash_fields;
    }
    algorithm : crc16;
    output_width : HH_BF_HASH_WIDTH;
}
action hh_bf_3_act() {
    modify_field_with_hash_based_offset(hh_bf_md.index_3, 0, hh_bf_3_hash, HH_BF_NUM);
    register_read(hh_bf_md.bf_3, hh_bf_3_reg, hh_bf_md.index_3);
    register_write(hh_bf_3_reg, hh_bf_md.index_3, 1);
}
table hh_bf_3 {
    actions = {
        hh_bf_3_act;
    }
}

control bloom_filter {
    hh_bf_1.apply();
    hh_bf_2.apply();
    hh_bf_3.apply();
}

field_list mirror_list {
    nc_load_md.load_1;
    nc_load_md.load_2;
    nc_load_md.load_3;
    nc_load_md.load_4;
}

#define CONTROLLER_MIRROR_DSET 3
action clone_to_controller_act() {
    clone_egress_pkt_to_egress(CONTROLLER_MIRROR_DSET, mirror_list);
}

table clone_to_controller {
    actions = {
        clone_to_controller_act;
    }
}

control report_hot_step_1 {
    clone_to_controller.apply();
}

#define CONTROLLER_IP 0x0a000003
action report_hot_act() {
    nc_hdr.op = NC_HOT_READ_REQUEST;
    
    add_header (nc_load); //TODO Devon I don't know what this does in modern p4
    ipv4.totalLen = 16;
    udp.len = 16;
    nc_load.load_1 = nc_load_md.load_1;
    nc_load.load_2 = nc_load_md.load_2;
    nc_load.load_3 = nc_load_md.load_3;
    nc_load.load_4 = nc_load_md.load_4;
    
    ipv4.dstAddr = CONTROLLER_IP;
}

table report_hot {
    actions {
        report_hot_act;
    }
}

control report_hot_step_2 {
    apply (report_hot);
}   

control heavy_hitter {
    if (standard_metadata.instance_type == 0) {
        count_min();
        if (nc_load_md.load_1 > HH_THRESHOLD) {
            if (nc_load_md.load_2 > HH_THRESHOLD) {
                if (nc_load_md.load_3 > HH_THRESHOLD) {
                    if (nc_load_md.load_4 > HH_THRESHOLD) {
                        bloom_filter();
                        if (hh_bf_md.bf_1 == 0 or hh_bf_md.bf_2 == 0 or hh_bf_md.bf_3 == 0){
                            report_hot_step_1();
                        }
                    }
                }
            }
        }
    }
    else {
        report_hot_step_2();
    }
}
