{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
  <div class="container">
    <div class="card">

      <div class="card-header">
        <h3 class="card-title">Message</h3>
      </div>
                
        <div class="card-body py-0">
          <div class="row mx-n5">
            <div class="col-md-3">

              <div class="row border border-top-0">
                <div class="input-icon mb-0" style="width: 100%;">
                  <input id="searchForRecents" type="text" class="form-control border-0" placeholder="Search for...">
                    <span class="input-icon-addon">
                      <i class="fe fe-search"></i>
                    </span>
                </div>
              </div>

              <div class="row border border-top-0">
                <h5 class="my-2 mx-2">RECENTS</h5>
              </div>

              <div class="row border border-top-0">
                <div id="recents" class="card-body o-auto py-0" style="height: 35rem">
                  
                </div>
              </div>
            </div>
            <div class="col-md-6 py-0 px-0 border border-top-0 border-bottom-0">
              <div class="card mb-0">
                <div class="card-header">
                  <div id="selectedUser"></div>
                </div>
                <div class="card-body py-0 px-0" style="height: 32rem">
                  <div id="chat-message-list" class="chat-message-list" ref="chat-message-list"></div>
                </div>
                <div class="card-footer py-0 px-0">
                  <div class="input-group composer">
                    <textarea id="message" class="form-control border" rows="2" placeholder="Type a message..."></textarea>  
                    <span class="input-group-append">
                      <button id="btnSend" class="btn text-white" type="button" disabled>Send</button>
                    </span>
                  </div>
                </div>
              </div> 
            </div>
            <div class="col-md-3">
              <div class="row border border-top-0">
                <div class="input-icon mb-0" style="width: 100%;">
                  <input id="searchForContacts" type="text" class="form-control border-0 input-focus" placeholder="Search for...">
                  <span class="input-icon-addon">
                    <i class="fe fe-search"></i>
                  </span>
                </div>
              </div>
              <div class="row border border-top-0">
                <h5 class="my-2 mx-2">CONTACTS</h5>
              </div>
              <div class="row border border-top-0">
                <div id="contacts" class="card-body o-auto py-0" style="height: 35rem">
                  
                </div>
              </div>
            </div>
          </div>    
        </div>
      </div>
    </div>
  </div>
</div>
<style scoped>
  .composer textarea {
    resize: none;
  }
  .btn {
    background: #499d7b;
  }
  #chat-message-list {
    grid-area: chat-message-list;
    display: flex;
    flex-direction: column;
    padding: 0 20px;
    background: #f0f0f0;
    height: 100%;
    max-height: 522px;
    overflow: scroll;
  }
  .message-content {
    display: grid;
  }
  .message-row{
    display: grid;
    grid-template-columns: 70%;
    margin-bottom: 20px;
  }
  .message-text {
    padding: 9px 14px;
    font-size: 1rem;
    margin-bottom: 5px;
  }
  .message-time {
    font-size: 0.6rem;
    color: #777;
  }
  .you-message .message-text {
    background: #fff;
    color:#111;
    border: 1px solid  #ddd;
    border-radius: 14px 14px 0 14px;
  }
  .you-message {
    justify-content: end;
    justify-items: end;
  }
  .other-message .message-text {
    background: #499d7b;
    color:#eee;
    border: 1px solid  #499d7b;
    border-radius: 14px 14px 14px 0px;
  }
  .other-message {
    justify-items: start;
  }
  .other-message .message-content {
    grid-template-columns: 48px 1fr;
    grid-column: 10px;
  }
</style>
{/block}

