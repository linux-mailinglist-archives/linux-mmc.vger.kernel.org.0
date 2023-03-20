Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80A6C1956
	for <lists+linux-mmc@lfdr.de>; Mon, 20 Mar 2023 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjCTPcp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 Mar 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjCTPc0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2023 11:32:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E870D13DCC
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2023 08:25:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13so12512624pjh.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679325913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4ZPHfMn9ZrHO7nzt0vTCldpfJhClttgBh55waccA2k=;
        b=DVo5f2DZTepL6uwwNvLriz+dqhUYAKmC1TKsmL/eJXOJEXscRqEz+oTeqdG0PZgWBY
         nYVfOV4f8QX5UOjjTCGWddf+HovepAmqsGU3++OjLh1afgLd7EfjzA+mjmRyXh7lypiN
         kK+L5N2Hphl+9aEfa/dwKwn8iGIcHFYZrKGozto8Se4+YfDGzEnbA9GG5lTE0keY8Yu0
         A8O+QyNzBMU9DOLr3OXUtLjajENURRfN1GTy/b7Kl+XtKNAslIJkMOnU2UrK8JJ8Aiw8
         /Y75oVyFPc4QOUN/8LnN2EFsKM0FvK7T2sLAKsThnTeiXWuSu+ClnSQG8xgKr1ZgWoRG
         J3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4ZPHfMn9ZrHO7nzt0vTCldpfJhClttgBh55waccA2k=;
        b=RlvXaLUmuqwHgGAtSbpfNevVW3o/EHn8vO/5dfn+jL1lybNSfLKDuEGioTTOo+sfU0
         dy4eYSDbGuBgKdMWBRb1WoeGjlmhqxl4fD9QgV/BlcrBFiJwacwSVmfik8wJmld64W6M
         eH6hwmvI6/bf0Vd3c/4Lxo7l8sz9jdSdPdnvWrhDO5wsixWLKSC0DnyVQ3pSjdrdlta3
         d0uXU0ratyfr2bUaOiyJsjQ6sYVpbuut6Ro0W47gNSufQQPBw96XitR+jodnZy+K7F/d
         OUCaPyfI+ydLz+a/DAM/TyFDJtQ6KkZo0lxwI4KItIQzNbAilkk91qiLOOfE+tt6KbUb
         XI6g==
X-Gm-Message-State: AO0yUKW2SrDxByra74i22ej6GfHyZtr9ZbJNzvaBYAx5KZ/E2z37/LPG
        9/+5PVBoiYE2KoDla3nlYa8KIdJLSFm7SRScLwFKKA==
X-Google-Smtp-Source: AK7set/tUkf1EmnvActHjEBsR9UHWqB2VVh4wJlOm6K5unVvW13dpF6gbyZ1Y1vdBoiiAf5iFUF7uimp/rwdBfqy6xE=
X-Received: by 2002:a17:902:d484:b0:1a1:adc5:c4d with SMTP id
 c4-20020a170902d48400b001a1adc50c4dmr3947292plg.13.1679325913008; Mon, 20 Mar
 2023 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <ZBNIg8+rOdFKcsS8@infradead.org> <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
 <ZBf8dZm1FZIusMls@infradead.org>
In-Reply-To: <ZBf8dZm1FZIusMls@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Mar 2023 16:24:36 +0100
Message-ID: <CAPDyKFogTyf30X+3JGeqf+yER_OLQ8JwXy6oEF3Rn78KzLSDxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Mar 2023 at 07:25, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 16, 2023 at 09:12:35PM +0200, Adrian Hunter wrote:
> > Historically file systems have assumed that sectors are updated
> > atomically i.e. there is never a sector with a mixture of
> > old and new data.
>
> Yes.  Not just file systems, but also all kinds of applications.
>
> > The eMMC spec does not guarantee that,
> > except for the eMMC "reliable write" operation.
>
> Neither to ATA or SCSI, but applications and file systems always very
> much expected it, so withou it storage devices would be considered
> fault.  Only NVMe actually finally made it part of the standard.

Even if the standard doesn't say, it's perfectly possible that the
storage device implements it.

Hence, $subject patch isn't changing anything in regards to REQ_FUA,
unless the eMMC device/vendor has agreed to this (via the MMC card
quirks).

>
> > So the paragraph
> > above is informing the potential benefit of reliable write instead
> > of cache flush.
>
> But these are completely separate issue.  Torn writes are completely
> unrelated to cache flushes.  You can indeed work around torn writes
> by checksums, but not the lack of cache flushes or vice versa.

It's not a separate issue for eMMC. Please read the complete commit
message for further clarifications in this regard.

>
>
> > Note, it is not that eMMC cannot avoid torn sectors, it is that
> > the specification does not mandate that they do.
>
> If devices tear writes it will break not only various file systems,
> but more importantly applications, at least on file systems without
> data checksum (aka all except for btrfs, and even that has a nodatacsum
> option).

Yes, you are correct. Again, the card quirk (as suggested in $subject
patch) helps us to manage eMMC cards in different ways. We should not
avoid REQ_FUA (reliable writes) for an eMMC that actually needs it.

>
> > However, the issue has been raised that reliable write is not
> > needed to provide sufficient assurance of data integrity, and that
> > in fact, cache flush can be used instead and perform better.
>
> It does not.

Can you please elaborate on this?

The tests we have done so far indicate that performance differs based
upon what eMMC we are using, for example.

Kind regards
Uffe
