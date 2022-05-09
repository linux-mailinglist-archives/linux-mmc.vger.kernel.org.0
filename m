Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D351FA21
	for <lists+linux-mmc@lfdr.de>; Mon,  9 May 2022 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiEIKns (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 May 2022 06:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEIKnr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2022 06:43:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF8C2C5C58
        for <linux-mmc@vger.kernel.org>; Mon,  9 May 2022 03:39:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k2so18781608wrd.5
        for <linux-mmc@vger.kernel.org>; Mon, 09 May 2022 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=8SQPJVfXBI6wE5085yv589WB6t++lgy8ytu1R8uzGzs=;
        b=FbCt4qc6E7J+d79alD/uJsBLV9cOldFh7+y1ZN3ZBPP531bmJjVyzGLxXCW3LnPl5Z
         HQjrm7ybDE79UKg0sbYB+dn+uUkBrA5G9KAxNXEe9ZGpa/bMgHRZr+gXykxx6mH4AOYr
         YyhqgLufWtDhRPCAhu4U5DdBkSMDVfYs6VLaGdm/iCatmtj43Pe4scjR2nH+o6D06BKZ
         R79XKKjyoWuMuizSkNOOAVoG0bnSUiMOn3SN+K1Zi8iomQn0FI6X82bhrlb0ZdkrfNHc
         xEfBNHV+UNzQQt/TGYFq189ysFcu5B+hLqY8ebmxgnz8e/dAV/ibcgkA0zh9G/+Rjsav
         SM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=8SQPJVfXBI6wE5085yv589WB6t++lgy8ytu1R8uzGzs=;
        b=70tcjZFFp1KVZ/Ixy1OIEeBq+z+5iQJxZZoMoFSYtDswL2XuNztf7lyj/ZYH1Wo1rt
         DEyJp7hdbSC3qHjWv73liT3LS2d3zQOYC9M4XRFR5iiuYVBv5U9v9MNEf/j4g8HAYQ4z
         8DPJTaWIeMfedQZO3JGqjTGTL40xUm0/yAKBsgYg1yb4J7hP5uLdHsMeQXHjQm+UXAnn
         91KZxxQ2lx1nikcfvqGRo7j1TpiDJsHb6BUBkKLjf/u7dEQpaPqBrizBQS09C939O19I
         2OiJLf155vxPOqErA5hvSV24prsrwKZsJcJIVgE25GfcSMglUQxzTa4fZYK25Tz3ZzD0
         jfUw==
X-Gm-Message-State: AOAM5320x0io/gljdX0vtexP8zsUKX9EdCeBF7B/+q2QA0oH7uCYZPtj
        3B2Pu+v10Lbf0h7vV2jHTy8=
X-Google-Smtp-Source: ABdhPJwwSkH6kJtRGlB1ahOjAJkHz0VmjNbgD21C456pa1WWJ3yj1GMt+hvtQMku7uAwrUUbsWiXyA==
X-Received: by 2002:adf:f350:0:b0:20a:dfc8:f8bf with SMTP id e16-20020adff350000000b0020adfc8f8bfmr13301381wrp.377.1652092571952;
        Mon, 09 May 2022 03:36:11 -0700 (PDT)
Received: from [192.168.24.107] ([105.112.154.43])
        by smtp.gmail.com with ESMTPSA id e10-20020adff34a000000b0020c7ec0fdf4sm12218780wrp.117.2022.05.09.03.36.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2022 03:36:11 -0700 (PDT)
Message-ID: <6278ee9b.1c69fb81.bee93.fc7b@mx.google.com>
From:   "Mr. GODWIN EMEFIELE" <kaashimaeliza@gmail.com>
X-Google-Original-From: "Mr. GODWIN EMEFIELE" <info@officecbn.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Dear beneficiary
To:     Recipients <info@officecbn.org>
Date:   Mon, 09 May 2022 11:36:03 +0100
Reply-To: mrgodwinenf98@gmail.com
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,YOU_INHERIT autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrgodwinenf98[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kaashimaeliza[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 YOU_INHERIT Discussing your inheritance
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CENTRAL BANK OF NIGERIA,
OPERATIONS DIRECTORATE,
566 TO 599 VICTORIA ISLAND,
LAGOS NIGERIA.

Dear beneficiary,


This is very urgent and an urgent attention is needed.

In our office sometime last month, One Mr. John T. Kehoe of 1200
Fitch Way, Sacramento, Ca. 95864 filed an application contrary to your
Pending fund transfer. The above mentioned person visited this Bank yesterd=
ay with a power of attorney given in his favor by your good self, granting =
him the benefit to process and claim your inheritance of $15,000,000.00(Fif=
teen Million United States Dollars Only) for personal reasons.

He further Stated that the online account be terminated while the fund shou=
ld be wired to his Bank account with Bank of America, Routing Number 121000=
358.Our office have ask Mr. John T. Kehoe return back to the Bank within 48=
hours to enable us have a personal confirmation from you being hitherto the=
 beneficiary.

1. Did you instruct one Mr. John T. Kehoe of 1200 Fitch way, Sacramento, Ca=
. 95864, to claim and receive the payment on your behalf?
2. Did you sign any 'Deed of Assignment' in his favor thereby making him th=
e current beneficiary?

We are sorry to have delayed your instruction in giving out this fund since=
 we must adhere to the procedures of this honorable bank by making sure thi=
s request is verified and confirmed by the beneficiary and his existing att=
orney.

Your confirmation to the above will be appreciated. We look forward to hear=
ing from you soon.
Best Regards

Yours sincerely

OFFICIALLY  SIGNED.
MR. GODWIN EMEFIELE.
Executive Governor
Central Bank of Nigeria
Email:mrgodwinenf98@gmail.com
