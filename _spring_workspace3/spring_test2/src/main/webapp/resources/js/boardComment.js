console.log("comment js in");
console.log(bnoVal);

document.getElementById('cmtPostBtn').addEventListener('click',()=>{
    const cmtText = document.getElementById('cmtText');
    console.log("dd");
    if(cmtText.value == null || cmtText.value == ''){
        alert('댓글을 입력해주세요.');
        cmtText.focus();
        return false;
    }else{
        let cmtData={
            bno:bnoVal,
            writer : document.getElementById('cmtWriter').innerText,
            content: cmtText.value
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result =>{
            if(result ==='1'){
                alert("댓글 등록 성공~!");
                cmtText.value="";
            }
            //화면에 뿌리기
            spreadCommentList(cmtData.bno);
        })
    }
});

async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config={
            method:"post",
            headers:{
                'content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };

        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
};

async function getCommentListFromServer(bno, page){
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json(); //commentList return
        return result;
    } catch (error) {
        console.log(error);
    }
};

function spreadCommentList(bno, page=1){
    getCommentListFromServer(bno, page).then(result =>{
        console.log(result);
        //댓글 모양대로 뿌리기
        const div = document.getElementById('accordionExample');
        //댓글을 다시 뿌릴때 기존 값을 삭제x 1page 일경우만 삭제
        if(result.cmtList.length > 0){
            if(page==1){
                div.innerHTML = "";
            }
            for(let i =0; i<result.cmtList.length; i++){
                let add = `<div class="accordion-item" data-cno="${result.cmtList[i].cno}" data-writer="${result.cmtList[i].writer}">`;
                add += `<h2 class="accordion-header">`;
                add += `<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">`;
                add += ` no.${result.cmtList[i].cno} / ${result.cmtList[i].writer} / ${result.cmtList[i].regAt}</button>`;
                add += `</h2>`;
                add += `<div id="collapse${i}" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">`
                add += `<div class="accordion-body">`;
                add += `<button type="button" data-cno="${result.cmtList[i].cno}" class="btn btn-outline-danger btn-sm cmtModBtn" data-bs-toggle="modal" data-bs-target="#myModal">수정</button>`;
                add += `<button type="button" data-cno="${result.cmtList[i].cno}" class="btn btn-outline-warning btn-sm cmtDelBtn">삭제</button>`;
                add += `<input type="text" class="form-control cmtText" value=${result.cmtList[i].content}>`
                add += `</div></div></div>`;
                div.innerHTML += add;
            }
            //더보기
            let moreBtn = document.getElementById("moreBtn");
            console.log(moreBtn);
            if(result.pgvo.pageNo < result.endPage){
                moreBtn.style.visibility = 'visible'; //버튼표시
                moreBtn.dataset.page = page+1;
            }else{
                moreBtn.style.visibility = 'hidden'; //버튼숨김
            }
        }else{
            div.innerHTML = `<div class="accordion-body">Comment List Empty</div>`;
        }
    })
};

document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.id == 'moreBtn'){
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page);
    }else if(e.target.classList.contains('cmtModBtn')){
        const div = document.getElementById('accordionExample');
        // let cmtText = li.querySelector('.fw-board').nextSibling;//한 div안에서 같은 형제를 찾기
        let cmtText = div.querySelector(".cmtText").value;
        console.log(cmtText);
        //모달창에 기존 댓글 내용을 반영 (수정하기 편하게..)
        document.getElementById('cmtTextMod').value = cmtText;

        //수정 => cno,writer,content 을 위한 cno, writer data- 로 달기
        let div2 = document.querySelector(".accordion-item");
        console.log(div2);
        document.getElementById('cmtModBtn').setAttribute("data-cno", div2.dataset.cno);
        document.getElementById('cmtModBtn').setAttribute("data-writer", div2.dataset.writer);
    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod={
            cno:e.target.dataset.cno,
            writer:e.target.dataset.writer,
            content:document.getElementById('cmtTextMod').value
        }
        console.log(cmtDataMod);
        //비동기 보내기
        editCommentToServer(cmtDataMod).then(result =>{
            if(result == "1"){
                //모달창 닫기
                document.querySelector('.btn-close').click();
            }else{
                alert('수정 실패');
                //모달창 닫기
                document.querySelector('.btn-close').click();
            }
            //수정된 댓글 뿌리기 page=1
            spreadCommentList(bnoVal);
        })
    }else if(e.target.classList.contains('cmtDelBtn')){
        let div2 = document.querySelector(".accordion-item");
        let cno = div2.dataset.cno;
        removeCommentToServer(cno).then(result =>{
            if(result =="1"){
                alert("댓글 삭제 성공~!!");
                spreadCommentList(bnoVal);
            }
        })
    }
})

async function editCommentToServer(cmtDataMod){
    try {
        const url = '/comment/edit';
        const config={
            method:'put',
            headers:{
                'content-type':'application/json; charset-utf-8'
            },
            body: JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(errer);
    }
}

async function removeCommentToServer(cno){
    try {
            const url = "/comment/" + cno;
            const config = {
                method: "delete"
            }
            const resp = await fetch(url, config);
            const result = await resp.text();
            return result;

    } catch (error) {
        console.log(error);
    }
}