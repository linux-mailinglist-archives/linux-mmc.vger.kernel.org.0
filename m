Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64597839
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHULmv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 07:42:51 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:40215 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfHULmu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2019 07:42:50 -0400
Received: by mail-vs1-f43.google.com with SMTP id i128so1126088vsc.7
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2019 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGyJtTdRFEqrfXqlhHseje+wrcJeJ3BPrV0Pr+186RM=;
        b=Kb9Iejc3aTv5oxkmyGuITCztWfUGPcLp0qYQDkpvrCScPhVepU1Nhce3wbo0aSvO7G
         SBA2CAP1X6hkIlUWFziruhTlXHUWyZiTUnmK/joBDv+TYcVTneD/YQDvmExYkwEakKMX
         HJz9bAedHmmeGtmaTLK1HWjr7N0v3TgubaqJNTrdWl/mGk2f+wEaPmBe4akWDiUczsHT
         i/YUsONP8n7PshYjYtNL++MO0BSdUw5tYLJKPXgI4TPoAYQmRSeOdDd21uBrKc9zn+RE
         zwsNMooMNwA1LRkC6BB+jV/REk768CEh7DW2MGf2hNHc0fOltOEYuntnDac1BSZ8BSI2
         o8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGyJtTdRFEqrfXqlhHseje+wrcJeJ3BPrV0Pr+186RM=;
        b=HpwYLXVzKSq0uljBFd2a8D79ZSYHamONjuDTubqiw1zUFITg3EsAJBFIfc7f2k4S60
         xMt7kTppubFdjrTKepQ+kj3qVShCrfTRRlG+VynOKWrRys8jiUs+iyIzZpmEJbaxbxW1
         vLjZqLx5JZDTFc+2Cr+X8GkPZ+gH9rhzDJMFGf94IlfasEpRKZxghBE/jAsh3l9gbuI6
         rOwY4TlbTzzHUsmBYTdEifj/yB0YLj3vGsUifqlVtbBuPR7uxIA813JNIhH/qaC3KB6k
         /aAi1fEMH6ZvDtK/qK8Iehdb5H0JTliBBjnZ/lRanznc5Sd0Q/ylx00q7KfDngD9SR0v
         e+GQ==
X-Gm-Message-State: APjAAAXLX7EeiZc9+ZcL9O3H8y81b3+StfM7gMj0BNmtWVAbVac0xFSb
        gXBFcwLQgtjtmq+UnyShqbOTnjKNSETgYuCGEYkXvQ==
X-Google-Smtp-Source: APXvYqwukXTXyD7zal5XQi8m2++c8cKveD53MZ7qIhHK/oDyxwZA/K9VkjT3fOHYqV+UCsM6hwzGuAn8QAsEAdd2gsU=
X-Received: by 2002:a67:e287:: with SMTP id g7mr20330343vsf.200.1566387769610;
 Wed, 21 Aug 2019 04:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <1566252529-5074-1-git-send-email-shirley.her@bayhubtech.com> <3003d633-ac5a-be61-585b-02f96613c070@intel.com>
In-Reply-To: <3003d633-ac5a-be61-585b-02f96613c070@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 13:42:13 +0200
Message-ID: <CAPDyKFp9Sba96NO8O085BCZofqc3X_Z2prOsesrCdWRiS5NkJw@mail.gmail.com>
Subject: Re: Subject: [PATCH V7 1/3] mmc: sdhci-pci-o2micro: Change O2 Host
 PLL and DLL register name
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "max.huang@bayhbutech.com" <max.huang@bayhbutech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Aug 2019 at 13:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/08/19 1:08 AM, Shirley Her (SC) wrote:
> > Change O2 Host PLL and DLL register name
> >
> > Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
>
> Please do not prefix the subject by "Subject: "
> Please put a space after Signed-off-by:

Also, I recommend to run the checkpatch script (scripts/checkpatch.pl)
as it helps you to verify that each patch are formatted correctly.

[...]

Kind regards
Uffe
