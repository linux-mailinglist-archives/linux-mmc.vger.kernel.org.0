Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0771099A0
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfKZHke (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 02:40:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33215 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfKZHke (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Nov 2019 02:40:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so1705618wmi.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2019 23:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nG3bBMMryZrs4c5UWWWkvQvM/YhJ/bCLeyoDOz5UluE=;
        b=BaGGMzgFhnvHd8z25T4nQEepoej4CybQUk2Dcygyvggj1NCcuSWkxO2xMzOXGoo2rR
         Wc3JrO4Y9qJQvnRuj9mNtjGXIuXzjz9JjYWqU0RPGHnq3anH0zAhM74ubVlTZMGvuCi9
         kuD6PYuMvTgR7kTwtTcZmpHwj3V6/Pw7AlgjBQ4BaDDL690lxkYMOzz3CLMloWUgEzwS
         yR6enx5TXwgY9bUnp1M2RAi2XXXPiI+jocg3/CLrtOrfu/x5uvFBGLBjjtfwJu7i3oE+
         ltCjymuCiacp9lGg2vPdj6YV+DYRWtpSiEhVZXyyQN+LU/I2HZC0mxuqrm7FDAFsHx+W
         xSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nG3bBMMryZrs4c5UWWWkvQvM/YhJ/bCLeyoDOz5UluE=;
        b=mBJeOQZVTJb8PLhDTPp39shM0DTLgaUnQ0fcqZM2l8JogoLitP3RvHxQmwTB2HsfSY
         Ysuw72Pq4apPmylEhR1Eqb6wz5UN/uPQ6ZrmSiJIeE6i5NJGoSPKTlc530DlTuGzUtMp
         XcsgnOF1Myg1DcKrx6MmlG3c168hc6pamm8SBMoORkDpCZWyyfKnOvRVr0uoKNKdKRXK
         8jUbrbNjxFnX2P2J5tNWMtS3SnTzI/WYBWsvO7xu9EsvzSlDKjmrGb5i514E4pzsYuBw
         RhTz73s5MQUyjyM/lzbonRG9+9jBAwYEGI7zt6eOIcANXPuhjw9I6lQCBAaBXlD9bP7T
         avFw==
X-Gm-Message-State: APjAAAUkxuDdYqdSEI+23M062wnpV2goQIFJ1rpAP33cXg1Jt5mVwnmW
        6eVY+N6rWJ8uDxPs8tEAbd7YVA==
X-Google-Smtp-Source: APXvYqzl2VP95eYn6YfrgCIlE7Lq8yLU/BE75CvuGyidQ0ziqMApK4k6TkD21sQt4wGcGywTzqHQjw==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr2642106wmk.109.1574754029933;
        Mon, 25 Nov 2019 23:40:29 -0800 (PST)
Received: from [192.168.0.101] (88-147-34-204.dyn.eolo.it. [88.147.34.204])
        by smtp.gmail.com with ESMTPSA id 189sm2084974wmc.7.2019.11.25.23.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 23:40:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
Date:   Tue, 26 Nov 2019 08:40:27 +0100
Cc:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C0831B6-CA26-4794-9686-E7384713C756@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Il giorno 22 nov 2019, alle ore 10:50, Arnd Bergmann <arnd@arndb.de> =
ha scritto:
>=20
> (adding Paolo as well, maybe he has some more insights)
>=20
> On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang
> <baolin.wang@linaro.org> wrote:
>> On Tue, 12 Nov 2019 at 16:48, Baolin Wang <baolin.wang7@gmail.com> =
wrote:
>>> On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>>> On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang =
<baolin.wang@linaro.org> wrote:
>>>>>> - With that change in place calling a blocking __mmc_claim_host() =
is
>>>>>>  still a problem, so there should still be a nonblocking =
mmc_try_claim_host()
>>>>>>  for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
>>>>>>  return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
>>>>>>  should always return right away, either after having queued the =
next I/O
>>>>>>  or with an error, but not waiting for the device in any way.
>>>>>=20
>>>>> Actually not only the mmc_claim_host() will block the MMC request
>>>>> processing, in this routine, the mmc_blk_part_switch() and
>>>>> mmc_retune() can also block the request processing. Moreover the =
part
>>>>> switching and tuning should be sync operations, and we can not =
move
>>>>> them to a work or a thread.
>>>>=20
>>>> Ok, I see.
>>>>=20
>>>> Those would also cause requests to be sent to the device or the =
host
>>>> controller, right? Maybe we can treat them as "a non-IO request
>>>=20
>>> Right.
>>>=20
>>>> has successfully been queued to the device" events, returning
>>>> busy from the mmc_mq_queue_rq() function and then running
>>>> the queue again when they complete?
>>>=20
>>> Yes, seems reasonable to me.
>>>=20
>>>>=20
>>>>>> - For the packed requests, there is apparently a very simple way =
to implement
>>>>>>  that without a software queue: mmc_mq_queue_rq() is allowed to =
look at
>>>>>>  and dequeue all requests that are currently part of the =
request_queue,
>>>>>>  so it should take out as many as it wants to submit at once and =
send
>>>>>>  them all down to the driver together, avoiding the need for any =
further
>>>>>>  round-trips to blk_mq or maintaining a queue in mmc.
>>>>>=20
>>>>> You mean we can dispatch a request directly from
>>>>> elevator->type->ops.dispatch_request()?  but we still need some =
helper
>>>>> functions to check if these requests can be packed (the package
>>>>> condition), and need to invent new APIs to start a packed request =
(or
>>>>> using cqe interfaces, which means we still need to implement some =
cqe
>>>>> callbacks).
>>>>=20
>>>> I don't know how the dispatch_request() function fits in there,
>>>> what Hannes told me is that in ->queue_rq() you can always
>>>> look at the following requests that are already queued up
>>>> and take the next ones off the list. Looking at bd->last
>>>> tells you if there are additional requests. If there are, you can
>>>> look at the next one from blk_mq_hw_ctx (not sure how, but
>>>> should not be hard to find)
>>>>=20
>>>> I also see that there is a commit_rqs() callback that may
>>>> go along with queue_rq(), implementing that one could make
>>>> this easier as well.
>>>=20
>>> Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last =
may
>>> can not work well, see [1]), but like we talked before, for packed
>>> request, we still need some new interfaces (for example, a interface
>>> used to start a packed request, and a interface used to complete a
>>> packed request), but at last we got a consensus that we should =
re-use
>>> the CQE interfaces instead of new invention.
>>>=20
>>> [1] https://lore.kernel.org/patchwork/patch/1102897/
>>>=20
>>>>=20
>>>>>> - The DMA management (bounce buffer, map, unmap) that is =
currently
>>>>>>  done in mmc_blk_mq_issue_rq() should ideally be done in the
>>>>>>  init_request()/exit_request()  (?) callbacks from mmc_mq_ops so =
this
>>>>>>  can be done asynchronously, out of the critical timing path for =
the
>>>>>>  submission. With this, there won't be any need for a software =
queue.
>>>>>=20
>>>>> This is not true, now the blk-mq will allocate some static request
>>>>> objects (usually the static requests number should be the same =
with
>>>>> the hardware queue depth) saved in struct blk_mq_tags. So the
>>>>> init_request() is used to initialize the static requests when
>>>>> allocating them, and call exit_request to free the static requests
>>>>> when freeing the 'struct blk_mq_tags', such as the queue is dead. =
So
>>>>> we can not move the DMA management into the =
init_request/exit_request.
>>>>=20
>>>> Ok, I must have misremembered which callback that is then, but I =
guess
>>>> there is some other place to do it.
>>>=20
>>> I checked the 'struct blk_mq_ops', and I did not find a ops can be
>>> used to do DMA management. And I also checked UFS driver, it also =
did
>>> the DMA mapping in the queue_rq() (scsi_queue_rq() --->
>>> ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed =
something?
>>>=20
>>> Moreover like I said above, for the packed request, we still need
>>> implement something (like the software queue) based on the CQE
>>> interfaces to help to handle packed requests.
>>=20
>> After some investigation and offline discussion with you, I still =
have
>> some concerns about your suggestion.
>>=20
>> 1) Now blk-mq have not supplied some ops to prepare a request, which =
is
>> used to do some DMA management asynchronously. But yes, we can
>> introduce new ops for blk-mq. But there are still some remaining
>> preparation in mmc_mq_queue_rq(), like mmc part switch. For software
>> queue, we can prepare a request totally after issuing one.
>=20
> I suppose to make the submission non-blocking, all operations that
> currently block in the submission path may have to be changed first.
>=20
> For the case of a partition switch (same for retune), I suppose
> something like this can be done:
>=20
> - in queue_rq() check whether a partition switch is needed. If not,
>  submit the current rq
> - if a partition switch is needed, submit the partition switch cmd
>  instead, and return busy status
> - when the completion arrives for the partition switch, call back into
>  blk_mq to have it call queue_rq again.
>=20
> Or possibly even (this might not be possible without signifcant
> restructuring):
>=20
> - when preparing a request that would require a partition switch,
>  insert another meta-request to switch the partition ahead of it.
>=20
> I do realize that this is a significant departure from how it was done
> in the past, but it seems cleaner that way to me.
>=20
>> 2) I wonder if it is appropriate that using the irq threaded context
>> to dispatch next request, actually we will still introduce a context
>> switch here. Now we will complete a request in the hard irq handler
>> and kick the softirq to do time-consuming operations, like DMA
>> unmapping , and will start next request in the hard irq handler
>> without context switch. Moreover if we remove the BLK_MQ_F_BLOCKING =
in
>> future like you suggested, then we can remove all context switch. And
>> I think we can dispatch next request in the softirq context (actually
>> the CQE already did).
>=20
> I hope Hannes (or someone else) can comment here, as I don't
> know exactly what his objection to kicking off the next cmd in the
> hardirq was.
>=20
> I think generally, deferring all slow operations to an irqthread
> rather than a softirq is a good idea, but I share your concern that
> this can introduce an unnecessary latency between the the
> the IRQ is signaled and the time the following cmd is sent to the
> hardware.
>=20
> Doing everything in a single (irqthread) context is clearly simpler,
> so this would need to be measured carefully to avoid unnecessary
> complexity, but I think don't see anything stopping us from having
> the fast-path where the low-level driver first checks for any possible
> error conditions in hardirq context and the fires off a prepared cmd
> right away whenever it can before triggering the irqthread that does
> everything else. I think this has to be a per-driver optimization, so
> the common case would just have an irqthread.
>=20
>> 3) For packed request support, I did not see an example that block
>> driver can dispatch a request from the IO scheduler in queue_rq() and
>> no APIs supported from blk-mq. And we do not know where can dispatch =
a
>> request in queue_rq(), from IO scheduler? from ctx? or from
>> hctx->dispatch list? and if this request can not be passed to host
>> now, how to do it? Seems lots of complicated things.
>=20
> The only way I can see is the ->last flag, so if blk_mq submits =
multiple
> requests in a row to queue_rq() with this flag cleared and  calls
> ->commit_rqs() after the last one. This seems to be what the scsi
> disk driver and the nvme driver rely on, and we should be able to use
> it the same way for packed cmds, by checking each time in queue_rq()
> whether requests can/should be combined and reporting busy otherwise
> (after preparing a combined mmc cmd).
> blk_mq will then call commit_rqs, which should do the actual =
submission
> to the hardware driver.
>=20
> Now as you point out, the *big* problem with this is that we never
> get multiple requests together in practice, i.e. the last flag is =
almost
> always set, and any optimization around it has no effect.
>=20
> This is where I'm a bit lost in the code as well, but it seems that
> this is part of the current bfq design that only sends one request =
down
> the driver stack at a time, and this would have to change first before
> we can rely on this for packing requests.
>=20
> Paolo, can you comment on why this is currently done, or if it can
> be changed? It seems to me that sending multiple requests at
> once would also have a significant benefit on the per-request overhead
> on NVMe devices with with bfq.
>=20

Hi,
actually, "one request dispatched at a time" is not a peculiarity of
bfq.  Any scheduler can provide only one request at a time, with the
current blk-mq API for I/O schedulers.

Yet, when it is time to refill an hardware queue, blk-mq pulls as many
requests as it deems appropriate from the scheduler, by invoking the
latter multiple times.  See blk_mq_do_dispatch_sched() in
block/blk-mq-sched.c.

I don't know where the glitch for MMC is with respect to this scheme.

Thanks,
Paolo


>> Moreover, we still need some interfaces for the packed request
>> handling, from previous discussion, we still need something like MMC
>> software queue based on  the CQE to help to handle the packed =
request.
>>=20
>> So I think I still need to introduce the MMC software queue, on the =
one
>> hand is that it can really improve the performance from fio data and
>> avoid a long latency, on the other hand we can expand it to support
>> packed request easily in future. Thanks.
>>=20
>> (Anyway I will still post the V7 to address Adrian's comments and to
>> see if we can get a consensus there).
>=20
>=20
>     Arnd

