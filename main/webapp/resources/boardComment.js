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
            spreadCommentList(cmtData.bvo);
        })
    }
});

async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config={
            method:"post",
            headers:{
                'content-type': 'application; charset=utf-8'
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

async function getCommentListFromServer(bno){
    try {
        const resp = await fetch("/comment/" + bno);
        const result = await resp.json(); //commentList return
        return result;
    } catch (error) {
        console.log(error);
    }
};

function spreadCommentList(bno){
    getCommentListFromServer(bno).then(result =>{
        console.log(result);
        //댓글 모양대로 뿌리기
        const div = document.getElementById('accordionExample');
        if(result.length > 0){
            div.innerHTML = "";
            for(let i =0; i<result.length; i++){
                let add = `<div class="accordion-item">`;
                add += `<h2 class="accordion-header">`;
                add += `<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">`;
                add += ` no.${result[i].cno} / ${result[i].writer} / ${result[i].reg_date}</button>`;
                add += `</h2>`;
                add += `<div id="collapse${i}" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">`
                add += `<div class="accordion-body">`;
                add += `<button type="button" data-cno="${result[i].cno}" class="btn btn-outline-danger btn-sm cmtModBtn">수정</button>`;
                add += `<button type="button" data-cno="${result[i].cno}" class="btn btn-outline-warning btn-sm cmtDelBtn">삭제</button>`;
                add += `<input type="text" class="form-control cmtText" value=${result[i].content}>`
                add += `</div></div></div>`;
                div.innerHTML += add;
            }
        }else{
            div.innerHTML = `<div class="accordion-body">Comment List Empty</div>`;
        }
    })
}
