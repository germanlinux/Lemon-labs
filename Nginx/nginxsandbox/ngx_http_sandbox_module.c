/*
 * Copyright (C) Eric German germanlinux@yahoo.fr
 */

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>
/*
typedef struct {
    ngx_str_t   handler;
} ngx_http_sandbox_ctx_t;
*/
static char *ngx_http_set_sandbox(ngx_conf_t *cf, ngx_command_t *cmd,
                                 void *conf);


static ngx_command_t  ngx_http_sandbox_commands[] = {

    { ngx_string("sandbox"),
      NGX_HTTP_SRV_CONF|NGX_HTTP_LOC_CONF|NGX_CONF_FLAG,
      ngx_http_set_sandbox,
      0,
      0,
      NULL },

      ngx_null_command
};

static ngx_http_module_t  ngx_http_sandbox_module_ctx = {
    NULL,                                  /* preconfiguration */
    NULL,                                  /* postconfiguration */

    NULL,                                  /* create main configuration */
    NULL,                                  /* init main configuration */

    NULL,                                  /* create server configuration */
    NULL,                                  /* merge server configuration */

    NULL,                                  /* create location configuration */
    NULL                                   /* merge location configuration */
};

ngx_module_t  ngx_http_sandbox_module = {
    NGX_MODULE_V1,
    &ngx_http_sandbox_module_ctx,      /* module context */
    ngx_http_sandbox_commands,              /* module directives */
    NGX_HTTP_MODULE,                       /* module type */
    NULL,                                  /* init master */
    NULL,                                  /* init module */
    NULL,                                  /* init process */
    NULL,                                  /* init thread */
    NULL,                                  /* exit thread */
    NULL,                                  /* exit process */
    NULL,                                  /* exit master */
    NGX_MODULE_V1_PADDING
};

static ngx_int_t ngx_http_sandbox_handler(ngx_http_request_t *r)
{
    size_t             size;
    ngx_int_t          rc;
    ngx_buf_t         *b;
    ngx_chain_t        out;

  // ngx_http_sandbox_ctx_t  *sandboxconfig;
   // ngx_atomic_int_t   ap, hn, ac, rq, rd, wr;

    if (r->method != NGX_HTTP_GET && r->method != NGX_HTTP_HEAD) {
        return NGX_HTTP_NOT_ALLOWED;
    }

    rc = ngx_http_discard_request_body(r);

    if (rc != NGX_OK) {
        return rc;
    }

    r->headers_out.content_type.len = sizeof("text/html") - 1;
    r->headers_out.content_type.data = (u_char *) "text/html";

    if (r->method == NGX_HTTP_HEAD) {
        r->headers_out.status = NGX_HTTP_OK;

        rc = ngx_http_send_header(r);

        if (rc == NGX_ERROR || rc > NGX_OK || r->header_only) {
            return rc;
        }
    }

    char debut[] = "<html><head></head><body><h1>Wellcome in the sandbox module</h1>\n";
    char suite[]=  " <pre>location /nginx_sandbox {\nsandbox on;\n}</pre><p>\n\
                   Le parametre <b>sandbox</b> est pris en charge par la fonction:<p>\n\
                  <pre>static ngx_command_t  ngx_http_sandbox_commands[] = {\n\
                  { ngx_string(\"sandbox\"),\n\
	          NGX_HTTP_SRV_CONF|NGX_HTTP_LOC_CONF|NGX_CONF_FLAG,\n\
                  <b>ngx_http_set_sandbox</b>,\n\
                  0,\n\
                  0,\n\
                  NULL },</pre>\
                  Ce bloc prend en charge l'option et appelle la fonction  <b>ngx_http_set_sandbox</b>\
                  qui installe la fonction <b>ngx_http_sandbox_handler</b> comme handler.\n\
                   <pre>\
static char *ngx_http_set_sandbox(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)\
{\n\
    ngx_http_core_loc_conf_t  *clcf;\n\
    clcf = ngx_http_conf_get_module_loc_conf(cf, ngx_http_core_module);\n\
    <b>clcf->handler = ngx_http_sandbox_handler;</b>\
    \nreturn NGX_CONF_OK;\n\
     }\n\
                   </pre><p><p>URI:";

 char separator[]="<p>" ;
 //char suite2[]= "Valeur du parametre <b< \'sandbox\'</b>:";
 char suite1[]= "ARGS:";
 char fin[] = "</body></html>\n";
                  
  // sandboxconfig =ngx_http_get_module_loc_conf(r, ngx_http_sandbox_module);
   ngx_str_t ws_uri = r->uri;
   ngx_str_t ws_args = r->args;
  
	
     
     size = sizeof(debut)
          + sizeof(suite) 

//          + sizeof(ws_uri.data)
         + ws_uri.len  
          + ws_args.len
  //        + ws_param.len
          + sizeof(separator)
          + sizeof(suite1)
//          + sizeof(suite2)
//          + sizeof(separator)
         +  sizeof(fin)  
 ;
   ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size: %d", size);
   ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size1: %d", sizeof(debut));
ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size2: %d", sizeof(suite));
ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size3: %d", ws_uri.len);
ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size31: %d", ws_args.len);

ngx_log_error(NGX_LOG_INFO, r->connection->log, 0,
                      "my_size4: %d", sizeof(fin));

   // ngx_log_error(NGX_LOG_DEBUG_HTTP, r->connection->log, 0, "sandbox_1: \"%V\"", size);

    b = ngx_create_temp_buf(r->pool, size);
    if (b == NULL) {
        return NGX_HTTP_INTERNAL_SERVER_ERROR;
    }

    out.buf = b;
    out.next = NULL;
/*
    ap = *ngx_stat_accepted;
    hn = *ngx_stat_handled;
    ac = *ngx_stat_active;
    rq = *ngx_stat_requests;
    rd = *ngx_stat_reading;
    wr = *ngx_stat_writing;
*/
    b->last = ngx_sprintf(b->last,debut);


    b->last = ngx_cpymem(b->last,suite,
                         sizeof(suite)-1 );
    
    b->last = ngx_cpymem(b->last,ws_uri.data,ws_uri.len );
    b->last = ngx_cpymem(b->last,separator,sizeof(separator)-1 );
    
    b->last = ngx_cpymem(b->last,suite1,sizeof(suite1)-1 );
    b->last = ngx_cpymem(b->last,ws_args.data,ws_args.len );
    b->last = ngx_cpymem(b->last,separator,sizeof(separator)-1 ); 
    //b->last = ngx_cpymem(b->last,suite2,sizeof(suite2)-1 );    
  //  b->last = ngx_cpymem(b->last,ws_param.data,ws_param.len );
    
   b->last = ngx_cpymem(b->last,fin,sizeof(fin)-1 );

    r->headers_out.status = NGX_HTTP_OK;
    r->headers_out.content_length_n = b->last - b->pos;

    b->last_buf = 1;

    rc = ngx_http_send_header(r);

    if (rc == NGX_ERROR || rc > NGX_OK || r->header_only) {
        return rc;
    }

    return ngx_http_output_filter(r, &out);
}

static char *ngx_http_set_sandbox(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
    ngx_http_core_loc_conf_t  *clcf;

    clcf = ngx_http_conf_get_module_loc_conf(cf, ngx_http_core_module);
    clcf->handler = ngx_http_sandbox_handler;
    //clcf->sanbox = "on";

     
    return NGX_CONF_OK;
}
