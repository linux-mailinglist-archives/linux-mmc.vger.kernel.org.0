Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8BF4560
	for <lists+linux-mmc@lfdr.de>; Fri,  8 Nov 2019 12:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfKHLIS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 8 Nov 2019 06:08:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43133 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfKHLIS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2019 06:08:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so1127316lfh.10
        for <linux-mmc@vger.kernel.org>; Fri, 08 Nov 2019 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6YNCEMzdVj3nGqDUF06aZU2cu0Jp7PocJPxqwyKwZHI=;
        b=Vx1xViU3t3C8sBjbI44NAUsvj9pC8QP0qzv1ZUvRgUpOGwHzL0OaC076HpM0hv0Rg+
         tha9C+jwYbpu0cIbMGCjfqCDQB29prk5hE00rui9azzxjGIrxJOgLm4E3hy1MqBGFhW+
         bHXG6375ruiYrtaXRV1l8KoXzhBTopxsH4PYY/nMBdJ4mHqS6zgGRkEd8Xu82lS1ovhM
         4LwNIeYpPMgU6UZI52+BsU2KVPhshOTlB3M2pquj7v3/p7xOx3Y/Kv8JlhyOk3GO3CTE
         DyEc9D9OCLa2Br/JMo/FExSITW1v0x/XLi2+HfFZ3zmqQzFbcSGgaGvjqZl0QAGWbgkl
         6FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6YNCEMzdVj3nGqDUF06aZU2cu0Jp7PocJPxqwyKwZHI=;
        b=JuMibhd8euvlnocdKg1oi7XDKpEalnRIqf+xSCepsuOVQADtQJVZa9nGUs1vWN5Suj
         9zoeCvjf77celTlyqydWJpE9ZA3eT9rMSo+6SfTs7sFF+okvJNgNdrrtLadlert6xJY/
         a7enCnYy0ftIft/XLvCZU3YpGORztWZd7nU6r+qFbXB3fjfRYfEKp9JJLHkoMqUnnlEz
         sG5lz2O7YoZ0bg+TwMLj0bEOJJXPTJJGdbLWu4bOPeW+nrf1HrbZYLt+ne43RmiK1Yn+
         85yeJ64kC5sZ7+r/sbmLn7s3BpiNAMqjh4yR9KQfCXbiXAb4z0ukvgJ2v8yVVWWzjNAG
         FOkQ==
X-Gm-Message-State: APjAAAUjwypo+LlzjhX0NRQKxzaJt3zrByYgjYH/r6aVHQAX4uM6JUJm
        Kyy+KufdVEGpykB046V+p72/5EBeg4dmvdwGy7yH1g==
X-Google-Smtp-Source: APXvYqwHSHcfo1EC8YQwmJdEFhoUb664wkodbYRiWOOUhzjsaptZ0edpD1dxOWGhTzcpxTiR8VkumcsAe7BQ1wqm97w=
X-Received: by 2002:a19:ec02:: with SMTP id b2mr5328048lfa.121.1573211296528;
 Fri, 08 Nov 2019 03:08:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:4296:0:0:0:0:0 with HTTP; Fri, 8 Nov 2019 03:08:15 -0800 (PST)
In-Reply-To: <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
References: <cover.1572326519.git.baolin.wang@linaro.org> <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com> <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
 <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com> <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 8 Nov 2019 19:08:15 +0800
Message-ID: <CAMz4ku+KVWw-M4AaPJ=Yn8xeLNaD2W4+gVqEN_P0QRwne3wwzA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 06/11/2019, Baolin Wang <baolin.wang@linaro.org> wrote:
> On Wed, 6 Nov 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/11/19 12:48 PM, Baolin Wang wrote:
>> > On Wed, 6 Nov 2019 at 18:10, Adrian Hunter <adrian.hunter@intel.com>
>> > wrote:
>> >>
>> >> On 29/10/19 7:43 AM, Baolin Wang wrote:
>> >>> When using the host software queue, it will trigger the next request
>> >>> in
>> >>> irq handler without a context switch. But the sdhci_request() can not
>> >>> be
>> >>> called in interrupt context when using host software queue for some
>> >>> host
>> >>> drivers, due to the get_cd() ops can be sleepable.
>> >>>
>> >>> But for some host drivers, such as Spreadtrum host driver, the card
>> >>> is
>> >>> nonremovable, so the get_cd() ops is not sleepable, which means we
>> >>> can
>> >>> complete the data request and trigger the next request in irq handler
>> >>> to remove the context switch for the Spreadtrum host driver.
>> >>>
>> >>> Thus we still need introduce a variable in struct sdhci_host to
>> >>> indicate
>> >>> that we will always to defer to complete data requests if the
>> >>> sdhci_request()
>> >>> can not be called in interrupt context for some host drivers, when
>> >>> using
>> >>> the host software queue.
>> >>>
>> >>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>> >>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >>> ---
>> >>>  drivers/mmc/host/sdhci.c |    2 +-
>> >>>  drivers/mmc/host/sdhci.h |    1 +
>> >>>  2 files changed, 2 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> >>> index 850241f..9cf2130 100644
>> >>> --- a/drivers/mmc/host/sdhci.c
>> >>> +++ b/drivers/mmc/host/sdhci.c
>> >>> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
>> >>> sdhci_host *host,
>> >>>  {
>> >>>       struct mmc_data *data = mrq->data;
>> >>>
>> >>> -     return host->pending_reset ||
>> >>> +     return host->pending_reset || (host->always_defer_done && data)
>> >>> ||
>>
>> To move ahead in the meantime without a new host API, just defer always
>> i.e.

Before new version, I want to make things clear in case I
misunderstood your points, so you mean I should set always_defer_done
= true for our Spreadtrum host driver in this patch? Or just like
below patch? Thanks.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..4bef066 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
sdhci_host *host,
 {
        struct mmc_data *data = mrq->data;

-       return host->pending_reset ||
+       return host->pending_reset || host->always_defer_done ||
               ((host->flags & SDHCI_REQ_USE_DMA) && data &&
                data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d89cdb9..a73ce89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -533,6 +533,7 @@ struct sdhci_host {
        bool pending_reset;     /* Cmd/data reset is pending */
        bool irq_wake_enabled;  /* IRQ wakeup is enabled */
        bool v4_mode;           /* Host Version 4 Enable */
+       bool always_defer_done; /* Always defer to complete requests */

        struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
        struct mmc_command *cmd;        /* Current command */

> And I'll wait for a while to see if Ulf will post some comments for
> this patch set before new version. Thanks.
>
>>
>> +     return host->pending_reset || host->always_defer_done ||
>>
>> >>
>> >> I didn't realize you still wanted to call the request function in
>> >> interrupt
>> >> context.  In my view that needs a new host API
>> >> i.e. int (*request_atomic)(struct mmc_host *mmc, struct mmc_request
>> >> *mrq)
>> >
>> > Actually there are no documentation said that the
>> > mmc_host_ops->request() is a sleepable API, so I introduce a
>> > host->always_defer_done flag to decide if the request can be called in
>> > interrupt context or not, since for some host drivers, the request()
>> > implementation can be called in interrupt context.
>> >
>> > Yes, I agree a new host API is more reasonable, if you do not like the
>> > current approach, I can add new patches to introduce the new
>> > request_atomic() API. But can I create another separate patch set to
>> > do this? since in this patch set, the Spreadtrum host driver's
>> > request() implementation can be called in interrupt context. Or you
>> > still want these changes introducing new request_atomic() can be done
>> > in this patch set? Thanks.
>> >
>> >>
>> >>>              ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>> >>>               data->host_cookie == COOKIE_MAPPED);
>> >>>  }
>> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> >>> index d89cdb9..38fbd18 100644
>> >>> --- a/drivers/mmc/host/sdhci.h
>> >>> +++ b/drivers/mmc/host/sdhci.h
>> >>> @@ -533,6 +533,7 @@ struct sdhci_host {
>> >>>       bool pending_reset;     /* Cmd/data reset is pending */
>> >>>       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>> >>>       bool v4_mode;           /* Host Version 4 Enable */
>> >>> +     bool always_defer_done; /* Always defer to complete data
>> >>> requests */
>> >>>
>> >>>       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done
>> >>> */
>> >>>       struct mmc_command *cmd;        /* Current command */
>> >>>
>> >>
>> >
>> >
>>
>
>
> --
> Baolin Wang
> Best Regards
>


-- 
Baolin Wang
Best Regards
