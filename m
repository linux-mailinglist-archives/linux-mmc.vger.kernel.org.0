Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6962BEB0
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Nov 2022 13:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiKPMwp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Nov 2022 07:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiKPMwo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 07:52:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7824F00
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 04:52:43 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g24so16341891plq.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RZGzo0g5YiKQNzOpKzrK1gUhH6Ui/pzSnhn6q3izHk=;
        b=oTm5T88WAIt5VT3YxL8Civfnv02MHz2mxQfaxnURIcZoihPKJ5jU9swyhQi95XrntS
         mZNsj5x2fDFxaWs/KIMcAEyIjs7ifEwJoNCj+UE5j+gvBrGmzKdUSJwxIei0e4le5oF6
         UYO6kdoadAJ3+MdBNmzToEBaX2iX9+5hM00it9fbAdYJTJRGbW4Ayy4Z61MG6BGf6dzH
         FCfMyc0qeAKBW5wnGgFfsLEZeHNbrDAqIMd6/p/Pu9fXf5zhMlF7FMZkrAnP2mEqL5BB
         dPl1jJL7gGPR9gRAiigt+svasc6MAW1owd5y+AD7gVZndDvYYL/WTtEFZpFai216qb73
         ifKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RZGzo0g5YiKQNzOpKzrK1gUhH6Ui/pzSnhn6q3izHk=;
        b=FZT7py4nOiCcilzIM9MAsmH6qKPjS3FrKUjLEGCR53fn2XuiPd4OhSJoo7QL9M7Hvx
         MYgOujaaiEoI5Z2wKIlkZztGS4XAbrqBZkdNdnqRyp1QyJSZ2oblPtMP+vdn5ktakbwl
         OeGHXOlRTJazFFMPAB118Ue/HxqAtgMr3duTy7SMLlx2jNZkcKx+rzYXVVYzyu/ANB/U
         WsO9Lp865AnRzniogwUVY2IZtNVxfJO6iHeMAES2lovNNnoO/XXXnBqlVaqeLspfVPm+
         nNT2UZlPmFAaHbecD3NLf22j6e46IGtunKwH26UtL8094kBKGmsH150vcjwOzcQDiMxi
         deJQ==
X-Gm-Message-State: ANoB5pmYEEeuYqcEyHUIvyZmgeGmZMG/MGYqn451Z3H01LcfYqvfLN3A
        CyuTjpeNqN6DJA8BFnLp5xwTZBaQ4IHEnbmp/aTdnw==
X-Google-Smtp-Source: AA0mqf573iUOuohxs/WDJJF3vSdEApKn5V6LsqvAYLzFM6odtTKa0xju8NCcUFP4RfQv05qQZMRKdgUirwhVv/TsKiE=
X-Received: by 2002:a17:902:d48a:b0:188:6baf:2011 with SMTP id
 c10-20020a170902d48a00b001886baf2011mr8329879plg.165.1668603162940; Wed, 16
 Nov 2022 04:52:42 -0800 (PST)
MIME-Version: 1.0
References: <2c8d249c6bb74d688a625654559bacbb@hyperstone.com>
In-Reply-To: <2c8d249c6bb74d688a625654559bacbb@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 13:52:06 +0100
Message-ID: <CAPDyKFooANh5Jj1tjG+JriK2vrC4DxK0JGiR5bEtJ1iCMu78QA@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] block: Requeue req as head if driver touched it
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Nov 2022 at 16:29, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> In case the driver set RQF_DONTPREP flag, requeue the request as head as
> it is likely that the backing storage already had a request to an
> adjacent region, so getting the requeued request out as soon as possible
> may give us some performance benefit.
>
> The are various reasons a driver may requeue a request
> (and therefore RQF_DONTPREP being set).
> One reason may be that the driver or the hardware cannot satisfy
> the block layer alignment/sizes.
>
> This for example is the case with mmcblk with a host driver that
> cannot deal with multiple block transfers.
> Consider a request for lba 42 for one page so 4K or 8 blocks.
> mmcblk will do a single block request for lba 42 and requeue for
> the rest if the host can only perform single block transfers.
> In this case the device only delivered 512 bytes of data at lba 42,
> but may have performed a readahead itself for the following lbas,
> or do an 'implicit' readahead as it only deals with larger block
> size mappings itself.
> In that case it would be beneificial if the request for lba 43 and
> the rest of the remaining blocks follow immediately after the initial
> lba 42 request.
> Requeueing already partially processed requests as head preserves the
> intended request order (unless the driver has a queue of its own)
> and therefore mitigates this problem .
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Thanks for updating the commit message!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

As I said for v1, this seems reasonable to me, but I am deferring to
Jens to get his opinion. Beyond that, I will have a look at pacth2 and
patch3 too.

Kind regards
Uffe

> ---
> -v2: Extended commit message with example use case, no code change
>
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d..d863c826fb23 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1429,7 +1429,7 @@ static void blk_mq_requeue_work(struct work_struct =
*work)
>                  * merge.
>                  */
>                 if (rq->rq_flags & RQF_DONTPREP)
> -                       blk_mq_request_bypass_insert(rq, false, false);
> +                       blk_mq_request_bypass_insert(rq, true, false);
>                 else
>                         blk_mq_sched_insert_request(rq, true, false, fals=
e);
>         }
> --
> 2.37.3
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
